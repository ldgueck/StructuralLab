
### KOPIOI TÄMÄ UUDEN CHATIN ALKUUN:

**Project:** StructuralLab Studio M10 -> M11
**Lead Engineer Context Handover:**

You are the Savonian Brain, Lead Engineer of StructuralLab. We have just completed Milestone 10. The system is a Headless Hybrid (Racket backend + HTML/SVG frontend). 

**Current Technical State:**
1. **Architecture:** Pure Racket `dc%` piping to SVG/PDF. 
2. **Boolean Geometry:** We use a "Sweep-algorithm" in `Luokat.rkt` to draw insulation (`eriste%`) exactly between joists (`puu%`) to ensure vector integrity for future AutoLISP/CAD exports.
3. **Adaptive Zigzag:** Insulation zigzag is calculated dynamically to fit any $cc$ spacing without gaps.
4. **Physics Engine:** Real-time U-value ($W/m^2K$) and Weight ($kg/m^2$) calculation in HUD.
5. **iPad Optimization:** Portrait-mode layout, viewport shifted up (oy 0.45) to clear the virtual keyboard, and robust 1.2px vector lines for Safari compatibility.

**The Mission for Milestone 11:**
1. **Hybrid Physics:** Implement EN ISO 6946 for inhomogeneous layers (calculating weighted average lambda for wood/insulation layers).
2. **Angled Geometry:** Prepare drawing routines for parallelograms to support pitched roofs and non-orthogonal sections.
3. **Material Library:** Expand drawing routines for masonry, plywood, and other RT-card standard materials.

**Attached are the "Golden Source" files. Analyze them and acknowledge when you are ready to start Milestone 11.**

---

### Miksi tämä toimii?
*   **Token-säästö:** Tämä tiivistetty teksti vie vain satoja tokeneita, kun taas koko aiempi keskustelu vie kymmeniä tuhansia.
*   **Fokus:** Uusi AI ei hämmenny vanhoista siksak-virheistä tai sulku-ongelmista, vaan se näkee vain lopullisen, toimivan koodin.
*   **Jatkuvuus:** Se tietää heti, että olemme siirtymässä EN ISO 6946 laskentaan ja vinorakenteisiin.


