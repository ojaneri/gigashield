## GigaShield – Visual Firewall Dashboard

GigaShield is a single‑file, browser‑based dashboard that helps you design and explain
`iptables` firewall policies using a modern visual interface.  
It acts as a **read‑only, client‑side modelling tool**: you build or import rules in the UI,
preview the equivalent `iptables` commands, and then apply them manually on your servers.

The project is intentionally self‑contained – the whole UI (HTML, CSS and JavaScript) lives
inside `index.html`, with no backend or installation requirements.

---

### Key Features

- **Visual rule management**
  - Drag‑and‑drop rules between the `INPUT`, `OUTPUT` and `FORWARD` chains.
  - Reorder cards to reflect the effective processing order within each chain.

- **Guided rule creation**
  - Create rules via a modal form selecting:
    - Chain (`INPUT`, `OUTPUT`, `FORWARD`)
    - Action (`ACCEPT`, `DROP`, `REJECT`)
    - Protocol (`TCP`, `UDP`, `ICMP`, `ALL`)
    - Port, source and destination addresses
    - Optional human‑readable description

- **Command preview (read‑only)**
  - Generate a complete set of `iptables` commands that represent the current model.
  - Designed to be copied into shell scripts or configuration management pipelines.
  - The UI itself **never** executes or persists these commands.

- **Import existing rules**
  - Paste the output of:
    - `sudo iptables -L -n -v --line-numbers`
  - A simple heuristic parser reconstructs high‑level rules for the `filter` table
    and the `INPUT`, `OUTPUT`, `FORWARD` chains.
  - Imported rules can then be rearranged, documented and exported again.

- **Real‑time visualisation**
  - Quick numerical summary of:
    - Total rules
    - Active chains
    - ACCEPT vs DROP/REJECT counts
  - Port‑centric charts:
    - Top allowed ports (ACCEPT)
    - Top blocked ports (DROP/REJECT)
  - Stacked bar showing rule distribution across `INPUT`, `OUTPUT`, `FORWARD`.

- **Executive PDF report**
  - Generate a PDF “executive report” that:
    - Explains the chain architecture and key services.
    - Describes each rule in business language (impact / rationale).
    - Highlights common risks and recommendations (e.g. SSH exposure, Telnet usage).
  - Built entirely in the browser using `jsPDF` and `DOMPurify` (for sanitisation).

- **Language support**
  - UI strings available in:
    - Brazilian Portuguese (`pt-BR`)
    - English (`en`)
  - Language is switched at runtime via a selector; all text is stored in a
    translation map inside `index.html`.

- **Responsive dark UI**
  - Modern dark theme with smooth hover/drag states.
  - Layout adapts to different screen sizes, including laptops and tablets.
  - All styling is in a single `<style>` block to keep deployment simple.

- **Sample rules**
  - On first load, the UI seeds a small set of demo rules (SSH, HTTP, Telnet, HTTPS)
    so that new users immediately see a realistic configuration.

---

### How It Works (Architecture)

- **State model**
  - All rules are kept in a `state` object in memory:
    - `state.table`: current iptables table (primarily `filter`).
    - `state.rules`: array of rule objects with:
      - `id`, `chain`, `proto`, `port`, `src`, `dst`, `action`, `note`.
  - Rendering functions (`renderLanes`, `renderCharts`, `updateSummary`) derive the UI
    directly from this state.

- **Translations**
  - A `translations` map stores all UI labels by language.
  - Elements declare `data-lang="key"` and are updated when the language changes.

- **Import / export**
  - Import:
    - `parseIptablesText()` parses text from `iptables -L -n -v --line-numbers`
      into the internal rule format.
  - Export:
    - `exportCommands()` builds the corresponding `iptables` command list and writes
      it to the on‑screen “terminal” preview.

- **PDF generation**
  - `generatePDF()` constructs an HTML string summarising the configuration,
    sanitises it with `DOMPurify`, and lets `jsPDF` render it into a downloadable PDF.

---

### Usage

1. **Open the dashboard**
   - Download or clone the repository.
   - Open `index.html` directly in any modern browser (Chrome, Firefox, Edge, etc.).
   - No web server, database or backend service is required.

2. **Create or adjust rules**
   - Click **“+ New rule”** or the floating **“+”** button.
   - Fill in chain, action, protocol, port, source, destination and note.
   - Save the rule, then drag the resulting card into the desired lane and position.

3. **Review and explain**
   - Use the summary and charts to quickly see the overall posture:
     - Which ports are open?
     - Which services are blocked?
     - How are rules distributed across chains?

4. **Import existing firewall configuration (optional)**
   - On the target server, run:

     ```bash
     sudo iptables -L -n -v --line-numbers
     ```

   - Copy the full output, paste it into the import textarea, and click
     **“Transform into visual”**.
   - Review and adjust the resulting visual model.

5. **Generate commands**
   - Click **“Generate iptables commands”**.
   - Copy the generated script from the terminal preview and apply it manually
     on the server (or integrate it into your automation tooling).

6. **Generate the executive PDF report (optional)**
   - Click **“Save Executive Report in PDF”**.
   - Share the generated PDF with management, auditors or clients as a
     human‑readable explanation of the firewall policy.

> **Important:** GigaShield does **not** make any changes to `iptables` or the
> operating system. It only models and previews rules in the browser.

---

### Limitations & Security Notes

- The iptables parser is intentionally simple and focused on common cases.
  - It is **not** a full replacement for `iptables-save` parsing.
  - Complex or highly customised rules may not be interpreted correctly.
- All logic runs client‑side in the browser:
  - No data is sent to a server by this tool.
  - If you handle sensitive configurations, open the file locally and avoid
    using remote browsers or shared machines.
- For production deployments you may want to:
  - Implement a backend that:
    - Reads `iptables-save` output.
    - Produces a structured JSON model.
    - Consumes and validates models produced in this UI.

---

### Development Notes

- **Tech stack**
  - Pure HTML, CSS and vanilla JavaScript in a single file (`index.html`).
  - External libraries (via CDN):
    - `jsPDF` for PDF generation.
    - `html2canvas` reserved for possible future screenshot/export features.
    - `DOMPurify` for HTML sanitisation before passing content to jsPDF.

- **Extending the UI**
  - To add new text labels, update the `translations` map and `data-lang` attributes.
  - To change how rules are modelled, edit the `state.rules` structure and the
    rendering / export functions (`renderLanes`, `exportCommands`, `generatePDF`, etc.).

---

### Credits

Created by **Osvaldo Janeri Filho** (`osvaldo@perito.digital`)

- Website: `https://perito.digital`
- LinkedIn: `https://linkedin.com/in/ojaneri`
- Email: `osvaldo@perito.digital`

Project repository: `https://github.com/ojaneri/gigashield`

