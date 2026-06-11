
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
