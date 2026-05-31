#!/usr/bin/env node

import { existsSync, readFileSync, statSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const failures = [];
let passCount = 0;

const check = (label, passed, detail = "") => {
  if (passed) {
    passCount += 1;
    console.log(`PASS ${label}`);
    return;
  }

  failures.push(`${label}${detail ? `: ${detail}` : ""}`);
  console.error(`FAIL ${label}${detail ? `: ${detail}` : ""}`);
};

const readText = (relativePath) =>
  readFileSync(path.join(root, relativePath), "utf8");

const fileIsPresent = (relativePath) => {
  const absolutePath = path.join(root, relativePath);

  if (!existsSync(absolutePath)) {
    return false;
  }

  return statSync(absolutePath).size > 0;
};

const collectLocalReferences = (html) => {
  const references = new Set();
  const addReference = (value) => {
    const cleanValue = value.split("#")[0].split("?")[0];

    if (
      !cleanValue ||
      cleanValue.startsWith("#") ||
      cleanValue.startsWith("data:") ||
      /^[a-z][a-z0-9+.-]*:/i.test(cleanValue)
    ) {
      return;
    }

    references.add(cleanValue);
  };

  for (const match of html.matchAll(/\b(?:src|href)=["']([^"']+)["']/g)) {
    addReference(match[1]);
  }

  for (const match of html.matchAll(/url\(["']?([^"')]+)["']?\)/g)) {
    addReference(match[1]);
  }

  const swfMatch = html.match(/const\s+SWF_URL\s*=\s*["']([^"']+)["']/);
  if (swfMatch) {
    addReference(swfMatch[1]);
  }

  return [...references].sort();
};

const html = readText("index.html");

const requiredFiles = [
  "index.html",
  "assets/DieAI.swf",
  "assets/images/main-image.png",
  "assets/images/start-screen.png",
  "assets/images/intro-good.png",
  "assets/images/intro-hacked.png",
  "assets/images/level-one.png",
  "assets/images/game-over.png",
];

for (const filePath of requiredFiles) {
  check(`${filePath} exists and is non-empty`, fileIsPresent(filePath));
}

for (const reference of collectLocalReferences(html)) {
  check(`local reference resolves: ${reference}`, fileIsPresent(reference));
}

const requiredSnippets = [
  ["page title", "<title>DieAI - Flash Revival</title>"],
  ["Ruffle config", "window.RufflePlayer"],
  [
    "pinned Ruffle runtime",
    'const RUFFLE_SRC = "https://unpkg.com/@ruffle-rs/ruffle@0.2.0";',
  ],
  ["SWF path", 'const SWF_URL = "assets/DieAI.swf";'],
  ["file protocol guard", 'window.location.protocol === "file:"'],
  ["local-server fallback title", "Local server required"],
  ["local-server command", "python3 -m http.server 8000"],
  ["HTTP fallback title", "Ruffle is temporarily unavailable"],
  ["retry action", "data-retry-ruffle"],
  ["screens fallback action", 'href="#screens"'],
  ["status live region", 'id="ruffle" aria-live="polite"'],
  ["ready status", "Game loaded. Click inside the player"],
  ["WASD control", "<kbd>WASD</kbd>"],
  ["arrow control", "<kbd>Arrows</kbd>"],
  ["space control", "<kbd>Space</kbd>"],
  ["escape control", "<kbd>Esc</kbd>"],
];

for (const [label, snippet] of requiredSnippets) {
  check(`wrapper invariant: ${label}`, html.includes(snippet));
}

const fileGuardIndex = html.indexOf('window.location.protocol === "file:"');
const ruffleLoadIndex = html.indexOf("await loadRuffleScript();");

check(
  "file:// guard runs before Ruffle script load",
  fileGuardIndex !== -1 &&
    ruffleLoadIndex !== -1 &&
    fileGuardIndex < ruffleLoadIndex,
);

if (failures.length > 0) {
  console.error(
    `\nStatic wrapper smoke failed with ${failures.length} issue(s).`,
  );
  process.exit(1);
}

console.log(`\nStatic wrapper smoke passed (${passCount} checks).`);
