Rapport de stage
================

Ce dossier contient tous les éléments nécessaires pour compiler le rapport
de stage.

# Dossiers

- doc : j'y ai mis la documentation du rapport, *ie* le plan, les consignes de
  rédaction.
- img : j'y ai mis les images du rapport, celles que je n'ai plus à travailler sous R ou LaTeX.
- schema : les différents schémas du rapport en tikz la plupart du temps.

# Fichiers

- acro.tex : les acronymes du rapport.
- header.tex le fichier de configuration, charge les packages etc.
- endmatter.tex : la biblio, les annexes et autres figures.
- frontmatter.tex : la page de garde, les listes de figure et autre.

# Script de compilation

```sh
cd ~/stage/rapport_stage

latexmk -pdf rapport.tex \
        -f \
        -output-directory=.tmp \
        -pdflatex="pdflatex -interaction nonstopmode" \
        -pvc
```
