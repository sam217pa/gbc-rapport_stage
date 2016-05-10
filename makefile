CHAPTER=$(wildcard *.tex)
PDFLATEX=xelatex
TEXFLAGS=-interaction nonstopmode

preview: $(CHAPTER)
	latexmk rapport.tex

rapport: $(CHAPTER)
	$(PDFLATEX) rapport.tex $(TEXFLAGS)
	bibtex rapport
	$(PDFLATEX) rapport.tex $(TEXFLAGS)
	$(PDFLATEX) rapport.tex $(TEXFLAGS)

# latexmk -pdf rapport.tex -f -output-directory=.tmp \
# -pdflatex="$(PDFLATEX) -interaction nonstopmode"

commit:
	git add *.tex makefile schema/*.tex
	git commit -m "sauvegarde"

clean:
	latexmk -C rapport.tex
