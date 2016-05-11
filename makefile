CHAPTER=$(wildcard *_*.tex)
PDFLATEX=xelatex
TEXFLAGS=-interaction nonstopmode

preview: $(CHAPTER)
	latexmk rapport.tex

rapport.pdf: $(CHAPTER)
	$(PDFLATEX) rapport.tex $(TEXFLAGS)
	bibtex rapport
	$(PDFLATEX) rapport.tex $(TEXFLAGS)
	$(PDFLATEX) rapport.tex $(TEXFLAGS)

3_resultat.tex: src/conversion_tract.R img/trace_s.pdf
	Rscript $<

commit:
	git add *.tex makefile schema/*.tex
	git commit -m "sauvegarde"

clean:
	latexmk -C rapport.tex
