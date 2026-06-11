
# StructuralLab (Milestone 9)
### *A Racket-based Web Tool for Generating 2D Structural Detail Drawings*

StructuralLab is a lightweight web utility that converts text-based structural layer descriptions into 2D vector drawings (SVG and PDF). 

---

## 🏗 Key Features
* **Text-to-Drawing Parsing:** Generates structural detail cross-sections from simple text lists (e.g., material type and thickness).
* **Multi-Format Export:** Uses Racket's native drawing utilities to output both SVGs for web previewing and PDFs for documentation.
* **Web-Based Interface:** Hosted locally, allowing access from any browser-enabled device on the same network.

---

## 🧠 Technical Architecture
* **Backend:** Built with [Racket (Lisp)](https://racket-lang.org/). It handles coordinate calculations, material definitions, and rendering logic.
* **Rendering Engine:** Utilizes Racket's native `dc<%>` (drawing context) library to generate both vector SVGs and PDF files from the same source data.
* **Frontend:** A responsive HTML/JS web interface that displays the generated vector drawings and handles user input.

---

## 🛠 Prerequisites
Requires **Racket 8.x** or newer.

The project relies on the following built-in Racket collections:
* `web-server-lib` (for hosting the local web server)
* `draw-lib` (for SVG and PDF rendering)
* `json` (for handling data transfer between the frontend and backend)

---

## 🚀 Installation

### Windows
1. Download and install Racket from [racket-lang.org](https://racket-lang.org/).
2. Clone the repository:
   ```bash
   git clone https://github.com/your-username/StructuralLab.git
   cd StructuralLab
   ```
3. Run the server using DrRacket (open and run `web_server.rkt`) or via the command line:
   ```bash
   racket web_server.rkt
   ```

### Linux (Ubuntu / Debian derivatives)
1. Install Racket:
   ```bash
   sudo apt update
   sudo apt install racket
   ```
2. Clone the repository and navigate to the directory.
3. Start the server:
   ```bash
   racket web_server.rkt
   ```
*Note: Ensure your firewall allows traffic on port `8888` if accessing the tool from other devices on your local network.*

---

## 📖 Usage
1. Start the server on your local machine.
2. Open a browser and navigate to `http://localhost:8888` (or use your host machine's IP address if accessing from a tablet or phone).
3. In the input tab, enter your material specifications. Example input:
   ```text
   betoni 200
   eriste 300
   puu 150
   ```
4. Click **Update View** to generate the SVG preview.
5. Click **Save & PDF** to output a PDF drawing to the `projects/` directory.

---

## 🗺 Roadmap
- [x] **Milestone 9:** Basic server architecture and SVG/PDF rendering.
- [ ] **Milestone 10:** Integration of thermal calculation (U-value) algorithms.
- [ ] **Milestone 11:** AutoLISP script generation for importing drawings into CAD software (BricsCAD/AutoCAD).

---

## 📄 License
[MIT License](https://choosealicense.com/licenses/mit/)
