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

const pngDimensions = (relativePath) => {
  const absolutePath = path.join(root, relativePath);
  const buffer = readFileSync(absolutePath);
  const pngSignature = "89504e470d0a1a0a";

  if (buffer.subarray(0, 8).toString("hex") !== pngSignature) {
    return null;
  }

  return {
    width: buffer.readUInt32BE(16),
    height: buffer.readUInt32BE(20),
  };
};

const escapeRegExp = (value) => value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const metaContent = (attributeName, attributeValue) => {
  const escapedAttributeValue = escapeRegExp(attributeValue);
  const patterns = [
    new RegExp(
      `<meta\\s+${attributeName}=["']${escapedAttributeValue}["']\\s+content="([^"]+)"[^>]*>`,
      "i",
    ),
    new RegExp(
      `<meta\\s+content="([^"]+)"\\s+${attributeName}=["']${escapedAttributeValue}["'][^>]*>`,
      "i",
    ),
  ];

  for (const pattern of patterns) {
    const match = html.match(pattern);
    if (match) {
      return match[1];
    }
  }

  return null;
};

const canonicalHref = () => {
  const patterns = [
    /<link\s+rel=["']canonical["']\s+href=["']([^"']+)["'][^>]*>/i,
    /<link\s+href=["']([^"']+)["']\s+rel=["']canonical["'][^>]*>/i,
  ];

  for (const pattern of patterns) {
    const match = html.match(pattern);
    if (match) {
      return match[1];
    }
  }

  return null;
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
  "assets/images/social-preview.png",
];

for (const filePath of requiredFiles) {
  check(`${filePath} exists and is non-empty`, fileIsPresent(filePath));
}

const socialPreviewDimensions = pngDimensions(
  "assets/images/social-preview.png",
);

check(
  "social preview image is 1200x630",
  socialPreviewDimensions?.width === 1200 &&
    socialPreviewDimensions?.height === 630,
  socialPreviewDimensions
    ? `${socialPreviewDimensions.width}x${socialPreviewDimensions.height}`
    : "not a PNG",
);

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
  ["Ruffle focus action", "data-focus-ruffle"],
  ["Ruffle focus style", "#ruffle:focus-within"],
  ["Ruffle focus status sync", "syncPlayerFocusStatus"],
  ["Ruffle tab stop", 'player.setAttribute("tabindex", "0")'],
  ["reduced motion media query", "@media (prefers-reduced-motion: reduce)"],
  ["reduced motion scroll fallback", "scroll-behavior: auto;"],
  ["ready status", "Game loaded. Click inside the player or tab to it"],
  ["focused status", "Player focused. Use WASD"],
  ["WASD control", "<kbd>WASD</kbd>"],
  ["arrow control", "<kbd>Arrows</kbd>"],
  ["space control", "<kbd>Space</kbd>"],
  ["escape control", "<kbd>Esc</kbd>"],
];

for (const [label, snippet] of requiredSnippets) {
  check(`wrapper invariant: ${label}`, html.includes(snippet));
}

const siteUrl = "https://mikechaves.github.io/dieai-flash/";
const description =
  "Play DieAI, Michael Chaves's 2018 Flash game revived with Ruffle. Stop AICorp's Buddy Bots before the launch gets out of control.";
const socialImageUrl = `${siteUrl}assets/images/social-preview.png`;
const socialImageAlt =
  "DieAI title art showing one friendly Buddy Bot and one hacked Buddy Bot.";

const requiredMetadata = [
  ["description", "name", "description", description],
  ["OpenGraph title", "property", "og:title", "DieAI - Flash Revival"],
  ["OpenGraph description", "property", "og:description", description],
  ["OpenGraph type", "property", "og:type", "website"],
  ["OpenGraph site name", "property", "og:site_name", "DieAI"],
  ["OpenGraph URL", "property", "og:url", siteUrl],
  ["OpenGraph image", "property", "og:image", socialImageUrl],
  ["OpenGraph secure image", "property", "og:image:secure_url", socialImageUrl],
  ["OpenGraph image type", "property", "og:image:type", "image/png"],
  ["OpenGraph image width", "property", "og:image:width", "1200"],
  ["OpenGraph image height", "property", "og:image:height", "630"],
  ["OpenGraph image alt", "property", "og:image:alt", socialImageAlt],
  ["Twitter card", "name", "twitter:card", "summary_large_image"],
  ["Twitter title", "name", "twitter:title", "DieAI - Flash Revival"],
  ["Twitter description", "name", "twitter:description", description],
  ["Twitter image", "name", "twitter:image", socialImageUrl],
  ["Twitter image alt", "name", "twitter:image:alt", socialImageAlt],
];

for (const [
  label,
  attributeName,
  attributeValue,
  expectedContent,
] of requiredMetadata) {
  check(
    `metadata invariant: ${label}`,
    metaContent(attributeName, attributeValue) === expectedContent,
    `${attributeName}="${attributeValue}"`,
  );
}

check(
  "metadata invariant: canonical URL",
  canonicalHref() === siteUrl,
  canonicalHref() ?? "missing",
);

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
