Rapport de stage
================

Ce dossier contient tous les éléments nécessaires pour compiler le rapport
de stage.

- doc : j'y ai mis la documentation du rapport, *ie* le plan, les consignes de
  rédaction.
- img : j'y ai mis les images du rapport, celles que je n'ai plus à travailler sous R ou LaTeX. 
- schema : les différents schémas du rapport en tikz la plupart du temps.

# Script de compilation

```sh
cd ~/stage/rapport_stage

latexmk -pdf rapport.tex \
        -f \
        -output-directory=.tmp \
        -pdflatex="pdflatex -interaction nonstopmode" \
        -pvc
```
