
# StructuralLab (Milestone 9)
### *A Headless AI-CAD Hybrid for Structural Engineering*

StructuralLab is a lightweight, professional workstation designed to bridge the gap between AI-generated design concepts and technical engineering documentation. It uses a **"Savonian Lisp Brain"** to translate natural language structural descriptions into precise 1:1 vector drawings.

---

## 🏗 Why StructuralLab?
Traditional CAD software is often too heavy for the early conceptual phase. StructuralLab allows a lead engineer to:
- **Chat with AI** (like Gemini) to develop structural layers.
- **Instantly Prototype** details by pasting text scripts.
- **Maintain One Source of Truth:** A single Racket-based "Smart Material" class handles the rendering for the browser (SVG), documentation (PDF), and CAD (AutoLISP).

---

## 🧠 The Architecture
StructuralLab uses a **Headless Hybrid Architecture**:
- **Backend:** [Racket (Lisp)](https://racket-lang.org/) handles the logic, material DNA, and coordinate math.
- **Rendering:** Uses Racket’s native `dc<%>` abstraction to "pipe" drawings to both **SVG** (for the web) and **PDF** (for storage).
- **Frontend:** A minimalist HTML5/JS interface that functions as a "Universal Viewer" across Windows, Linux, and mobile devices (iPad).

---

## 🛠 Prerequisites
StructuralLab requires **Racket 8.x** or newer.

### Required Libraries (Racket)
The project uses the following built-in Racket collections:
- `web-server-lib` (For the Headless Server)
- `draw-lib` (For SVG/PDF rendering)
- `json` (For data exchange)

---

## 🚀 Installation

### Windows 11
1. **Install Racket:** Download from [racket-lang.org](https://racket-lang.org/).
2. **Clone the Repo:**
   ```bash
   git clone https://github.com/your-username/StructuralLab.git
   cd StructuralLab
   ```
3. **Run the Server:**
   Open `web_server.rkt` in DrRacket and press **Run**, or use the command line:
   ```bash
   racket web_server.rkt
   ```

### Linux (Xubuntu / Ubuntu)
1. **Install Racket:**
   ```bash
   sudo apt update
   sudo apt install racket
   ```
2. **Run the Server:**
   ```bash
   racket web_server.rkt
   ```
3. **Network Access:** Ensure your firewall allows traffic on port `8888` if accessing from other devices.

---

## 📖 Usage
1. Start the server on your main machine.
2. Open a browser on any device (PC, iPad, Surface) and go to `http://<your-ip>:8888`.
3. Paste a design script into the **Määrittely** (Definition) tab.
   *Example:*
   ```text
   betoni 200
   eriste 300
   puu 150
   ```
4. Click **Päivitä Näkymä** (Update View) to see the 1:1 SVG render.
5. Click **Tallenna & PDF** to generate a technical document in the `projects/` folder.

---

## 🗺 Roadmap
- [x] **Milestone 9:** Decoupled Headless Architecture & SVG/PDF Piping.
- [ ] **Milestone 10:** Real-time Thermal Calculation (U-Values) based on Material DNA.
- [ ] **Milestone 11:** Advanced AutoLISP export for BricsCAD/AutoCAD integration.

---

## 📄 License
[MIT](https://choosealicense.com/licenses/mit/) - Feel free to use and modify for your own engineering needs.

---

### What else goes on a GitHub page?
1. **Screenshots:** GitHub is visual. Take a good screenshot of your browser window (like the one you sent me with the eriste and puu layers) and add it to the top of the README.
2. **`.gitignore` file:** You should add a file named `.gitignore` to your project so you don't accidentally upload temporary files. It should contain:
   ```text
   compiled/
   projects/*/
   *.tmp
   .DS_Store
   ```
3. **Folder Tree:** It’s helpful to show the structure:
   ```text
   C:/StructuralLab/
   ├── web_server.rkt      # Server entry point
   ├── Luokat.rkt          # Class blueprints
   ├── materials.rktd      # Material database (DNA)
   ├── studio.html         # Web Interface
   └── projects/           # Saved detail data
   ```

Based on our final "Pure Racket" architecture, you should include only the files necessary to run the engine. We are intentionally excluding the old Python files and virtual environments to keep the repository clean and professional.

Here are the **7 specific items** you need to put in your GitHub repository:

### 1. The Core Logic
*   **`web_server.rkt`**: This is your main entry point. It’s the "Brain" that runs the server, handles the routes, and coordinates the SVG/PDF generation.
*   **`Luokat.rkt`**: This contains your class definitions (Material classes, Layer class, etc.). It’s the "Blueprint" for your object-oriented rendering.

### 2. The Data (DNA)
*   **`materials.rktd`**: Your material library. By keeping this as an S-expression file, other engineers can easily see how you’ve defined the structural properties ($lambda$, density, etc.).
*   **`display_config.rktd`**: This holds the viewport settings and layout proportions.

### 3. The Frontend
*   **`studio.html`**: The entire user interface. Since we moved the rendering logic to Racket, this file is now beautifully lightweight.

### 4. GitHub Essentials
*   **`README.md`**: The "cover page" we drafted. This explains the *why* and *how* to your son and other architects.
*   **`.gitignore`**: This is critical. It tells GitHub to ignore your temporary files, compiled Racket code, and your personal PDF exports.

---

### 📂 How your folder should look on GitHub:
```text
/StructuralLab
├── .gitignore
├── README.md
├── Luokat.rkt
├── display_config.rktd
├── materials.rktd
├── studio.html
├── web_server.rkt
└── projects/
    └── .gitkeep
└── screenshots/
    └── .gitkeep
```

🏗️🚀
