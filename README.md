# Academic Typst Slides for Quarto

A reusable Quarto format for academic PDF presentations.

## Install in an existing project


```sh
quarto add toledo60/quarto-academic-slides
```

In any document in that project:

```yaml
---
title: "Academic Presentation"
author: "Your Name"
format:
  academic-slides-typst: default
slide-aspect: "16:9"
slide-numbers: false
---
```

Render from your project root:

```sh
quarto render template.qmd
```


## Start a new presentation

```sh
quarto use template toledo60/quarto-academic-slides
```

Choose a new directory when prompted. Quarto copies the extension and the starter `template.qmd`, renaming the starter to match your directory. Then render the copied `.qmd`.

## Write slides

Use `## Slide title` for content slides and `# Section title` for divider slides. Ordinary Markdown supports text, lists, tables, images, code, links, and supported mathematical notation. See `template.qmd` for alerts, theorem blocks, columns, and a gray closing slide.

Use `slide-aspect: "4:3"` or `"16:9"`. Slide numbers are disabled by default. Font defaults are Arial, Menlo, and STIX Two Math; choose fonts installed on your system. Set format-specific options in document YAML to override defaults:

```yaml
format:
  academic-slides-typst:
    mainfont: Source Sans Pro
    codefont: Source Code Pro
    fontsize: 14pt
```

Shared styling is in `_extensions/academic-slides/typst-template.typ`.
