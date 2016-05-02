CHAPTER=$(wildcard *.tex)
TEXFLAGS=-interaction nonstopmode

preview: $(CHAPTER)
	latexmk -pdf rapport.tex -f -pdflatex="pdflatex $(TEXFLAGS)" -pvc

rapport: $(CHAPTER)
	pdflatex rapport.tex $(TEXFLAGS)
	bibtex rapport
	pdflatex rapport.tex $(TEXFLAGS)
	pdflatex rapport.tex $(TEXFLAGS)

# latexmk -pdf rapport.tex -f -output-directory=.tmp \
# -pdflatex="pdflatex -interaction nonstopmode"

commit:
	git add *.tex makefile schema/*.tex
	git commit -m "sauvegarde"

clean:
	latexmk -C rapport.tex
	rm -r .tmp
