# DieAI (Ruffle Web Revival)

This repo hosts a **Ruffle-powered** resurrection of my 2018 Flash game **DieAI**.  
Runs in any modern browser—no legacy plugins required.

<div align="center">
  <a href="https://mikechaves.github.io/dieai-flash/">
    <img src="https://img.shields.io/badge/Play-Now-Live-Demo-brightgreen" alt="Play DieAI">
  </a>
</div>

---

## 🎮 Live demo

👉 **Play here:** <https://mikechaves.github.io/dieai-flash/>

## 🕹 How to play

- **Arrow keys / WASD** — move  
- **Space** — primary action (attack / interact)  
- **Esc** — pause / restart  

## 📦 Project structure

```text
dieai-flash/
├── assets/
│   └── dieai.swf      # original Flash build
├── index.html         # Ruffle loader
├── README.md          # this file
└── LICENSE            # MIT by default
``` 

## 🚀 Running Locally
Clone the repository
```bash
git clone https://github.com/mikechaves/dieai-flash.git
``` 
Navigate into the directory
```bash
cd dieai-flash
``` 
Start a simple local server (requires Python 3)
```bash
python -m http.server 8000
``` 
Open http://localhost:8000 in your browser


## 🤝 Contributing

Thank you for your interest in improving **DieAI**!  
All kinds of help are welcome—bug reports, feature ideas, documentation fixes, or code contributions.

1. **Fork** the repo and create your branch:  
   ```bash
   git checkout -b feature/my-new-feature
   ```
2. **Commit** your changes with clear messages:
3. **Push** your branch and open a pull request:
4. Fill in the PR template. The maintainers will review, request tweaks if needed, and merge.
> **Coding style:** keep functions small, use descriptive variable names, and run `npm run lint` if you add any JS helpers.


## 📄 License

Released under the [MIT License](LICENSE).  
You may use, modify, and distribute this project—even for commercial purposes—provided you include the original copyright and license notice in any copies or substantial portions of the Software.

## 🙌 Credits

| Contribution | Author / Project |
|--------------|------------------|
| Game design, art & original ActionScript code | **Michael Chaves** |
| Flash → Web revival (WebAssembly emulator) | [Ruffle](https://github.com/ruffle-rs/ruffle) |
| Preservation reference & inspiration | [Flashpoint Archive](https://flashpointarchive.org/) |
