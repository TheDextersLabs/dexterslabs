# DextersLabs repository instructions

## Project shape

- This is a static GitHub Pages site; there is no package manifest, build system, test runner, or linter.
- Deployable content is the repository root: `index.html`, `projects.html`, `rv-projects.html`, and `CNAME`.
- `CNAME` configures the GitHub Pages custom domain.
- `README.md` describes the site as a home base for car-audio, RV, home-automation, and lab-project documentation.

## Commands

Serve the repository locally with Python's standard-library HTTP server:

```bash
python3 -m http.server 4173
```

Then open `http://localhost:4173/`.

There are no repository build, lint, or automated test commands. For browser checks, serve locally and inspect the relevant page directly. No single-test command exists because no test framework is configured.

## Page architecture

- `index.html` is the main interactive CAD/lab overview. It combines three sections: RV demolition and layout planning, a 40U power/homelab rack configurator, and the project overview. Its inline script owns navigation, structural zones, blueprint layers, caliper/tape tools, rack catalog/presets/mounting, and rack BOM export.
- `projects.html` is a standalone RV corner-workstation and 5V/12V routing drawing. It uses a separate inline state model and SVG renderer for orthographic, metalwork, and electrical views.
- `rv-projects.html` is a separate tabbed RV presentation containing the structural-zone and homelab-rack experiences. It has its own copy of much of the blueprint/rack behavior and is not linked to the shared module structure by the current pages.
- Pages use inline `<style>` and `<script>` blocks with no JavaScript modules or shared asset pipeline.
- Tailwind CSS is loaded from `https://cdn.tailwindcss.com`; JetBrains Mono and Inter are loaded from Google Fonts. Preserve these external dependencies or account for them when changing styling.

## Editing conventions

- Each HTML page is largely self-contained: keep page-specific markup, CSS, SVG, and JavaScript together unless intentionally introducing a shared asset system.
- Tailwind utility classes are used extensively alongside page-local CSS variables and custom classes. Match the existing blueprint theme: dark navy backgrounds, cyan/teal highlights, amber warning states, and rose destructive/demo states.
- JavaScript is primarily DOM-oriented and uses global functions invoked from `onclick` attributes. Preserve matching element IDs when moving or renaming controls.
- Update rendered SVG and DOM state in the associated JavaScript functions rather than relying on framework-style reactivity.
- Rack state is represented by plain data structures and mounted-item objects. Reuse `getHardwareById`, preset functions, and rack BOM-generation paths when changing the catalog or configurator.
- Structural-zone behavior uses stable zone IDs such as `front-bed`, `mid-demo`, `subfloor`, `rear-ramp`, and `roof-envelope`; keep the corresponding data, SVG `g` element, and pill/button IDs synchronized.
- Blueprint and rack measurement tools use coordinate conversions tied to SVG bounds and physical dimensions. If adjusting scale or drawing geometry, update the related tape/caliper conversion calculations and displayed units together.
- `index.html` and `rv-projects.html` contain overlapping implementations. Changes to shared interaction patterns may require updating both pages explicitly; do not assume a change in one is inherited by the other.
