Rapport de stage
================

Ce dossier contient tous les éléments nécessaires pour compiler le rapport
de stage.

TODOS :

## typesetting :

-  créer la page de garde.
-  supprimer les figures inutiles de l'endmatter.

# Script de compilation

```sh
cd ~/stage/rapport_stage

latexmk -pdf rapport.tex \
        -f \
        -output-directory=.tmp \
        -pdflatex="pdflatex -interaction nonstopmode" \
        -pvc
```

