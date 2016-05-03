Rapport de stage
================

Ce dossier contient tous les éléments nécessaires pour compiler le rapport
de stage.

# Script de compilation

```sh
cd ~/stage/rapport_stage

latexmk -pdf rapport.tex \
        -f \
        -output-directory=.tmp \
        -pdflatex="pdflatex -interaction nonstopmode" \
        -pvc
```

