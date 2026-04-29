
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
```
*(Note: I included a `.gitkeep` file inside the `projects/` folder. Git usually ignores empty folders, so putting a tiny hidden file there ensures the folder exists when someone else clones your project.)*

### ⚠️ What NOT to include (Double Check):
*   **DO NOT** include `bin/draftsman.py` or `bin/draw.bat` (unless you want to keep them as "legacy" examples).
*   **DO NOT** include the `.venv/` folder.
*   **DO NOT** include `compiled/` folders (Racket creates these automatically).
*   **DO NOT** include your actual project PDFs or design files (these stay private on your local machine).

=============================================================================================================================

### 1. Tiedostorakenne (Directory Tree)
Luo projektisi juureen tiedosto nimeltä `.gitignore`. Tämä varmistaa, että GitHubiin menee vain koodi, ei turhaa väliaikaistiedostoa tai sinun henkilökohtaisia projektisuunnitelmiasi.

**Tiedosto: `.gitignore`**
```text
# Racketin kääntämät binäärit
compiled/
*~

# Projektikohtaiset tiedot (ei ladata GitHubiin)
# Pidetään projects-kansio, mutta ei sen sisältöä
projects/**/*
!projects/.gitkeep

# Käyttöjärjestelmän roskat
.DS_Store
Thumbs.db

# Generoidut PDF-tiedostot
*.pdf
```

---

### 2. GitHub README.md (Se "Kansisivu")
Tämä on se sivu, jonka jokainen näkee ensimmäisenä. Olen kirjoittanut sen niin, että se selittää arkkitehtuurin (Headless Lisp + dc<%>) selkeästi.

**Tiedosto: `README.md`**
```markdown
# StructuralLab (Milestone 9)
### *A Headless AI-CAD Hybrid for Structural Engineering*

StructuralLab on kevyt mutta ammattimainen työkalu, joka muuntaa vapaamuotoisen tekstin teknisiksi 1:1 vektoripiirustuksiksi. Järjestelmä on suunniteltu erityisesti "AI-First" työnkulkuun, jossa tekoäly avustaa rakenteen suunnittelussa ja Lisp-pohjainen moottori varmistaa teknisen tarkkuuden.

---

## 🏗️ Arkkitehtuuri (The Architecture)

Järjestelmä perustuu **Headless Hybrid** -malliin, joka on irrotettu perinteisistä työpöytäkäyttöliittymistä:

- **Brain (Racket/Lisp):** Backend toimii paikallisena verkkopalvelimena. Se hallitsee materiaalien DNA:n (S-expressions), rakenteellisen pinoamislogiikan ja koordinaattimuunnokset.
- **Rendering Strategy ("Write Once, Render Anywhere"):** Käytän Racketin `dc<%>` (Drawing Context) -abstraktiota. Sama piirtokoodi tuottaa natiivin SVG-kuvan selaimelle ja teknisen PDF-dokumentin ilman ulkopuolisia kirjastoja (kuten Pythonia).
- **Frontend:** Ultra-kevyt HTML5/JS-käyttöliittymä, joka toimii kaikissa kodin laitteissa (Windows, Linux, iPad).

---

## 🧠 Tekninen DNA

Järjestelmä käyttää oliopohjaista lähestymistapaa materiaaleihin. Jokainen materiaali (esim. `eriste%`, `ontelo%`, `puu%`) on oma luokkansa, joka tietää:
- Teknisen datan (Lambda-arvo, tiheys).
- Piirtoasuaan vastaavan hatch-kuvion (siksak, pisteet, ristikko).

---

## 🚀 Asennus ja Käyttö

### Vaatimukset
- [Racket 8.10+](https://racket-lang.org/) tai uudempi.

### Asennus (Windows & Linux)
1. **Kloonaa repo:**
   ```bash
   git clone https://github.com/kayttajanimi/StructuralLab.git
   cd StructuralLab
   ```
2. **Käynnistä palvelin:**
   Avaa `web_server.rkt` DrRacketissä ja paina **Run**, tai aja komentoriviltä:
   ```bash
   racket web_server.rkt
   ```

### Käyttö
1. Avaa selain osoitteessa `http://localhost:8888`.
2. Syötä määrittely-välilehdelle materiaaleja, esim:
   ```text
   betoni 200
   eriste 300
   puu 150
   ```
3. Paina **Päivitä Näkymä** nähdäksesi SVG-vektorikuvan.

---

## 🗺️ Roadmap
- [x] **Milestone 9:** Headless-arkkitehtuuri ja SVG/PDF-putki.
- [ ] **Milestone 10:** Reaaliaikainen U-arvon (lämmönläpäisy) laskenta.
- [ ] **Milestone 11:** AutoLISP-integraatio ammattilais-CAD-ohjelmistoille.

---

## 📄 Lisenssi
Tämä projekti on lisensoitu MIT-lisenssillä – vapaaseen insinöörikäyttöön.
```

---

### 3. Viimeinen tarkistus tiedostoista

Varmista, että kansion sisältö näyttää tältä ennen kuin teet `git commit`:

1.  **`web_server.rkt`** (Pääohjelma)
2.  **`Luokat.rkt`** (Luokkapiirustukset)
3.  **`materials.rktd`** (Materiaali-data)
4.  **`studio.html`** (Käyttöliittymä)
5.  **`README.md`** (GitHub-sivu)
6.  **`.gitignore`** (Git-asetukset)
7.  **`projects/`** (Kansio, jossa on tyhjä tiedosto `.gitkeep`, jotta kansio pysyy tallessa mutta sisältö ei mene verkkoon).

**Vinkki poikaasi varten:**
Kun hän katsoo `Luokat.rkt` -tiedostoa, mainitse hänelle, että käytät **Mixineitä** tai **Polymorfismia** (kuten `define/override (get-hatch)`) ja että backend on täysin **stateless**. Nämä ovat termejä, joita ohjelmistoarkkitehdit arvostavat.

Tällä paketilla projektisi on valmis maailmalle. Onnea GitHub-julkaisuun! 🏗️🚀
