CHAPTER=$(wildcard *.tex)

preview: $(CHAPTER)
	latexmk -pdf rapport.tex -f -output-directory=.tmp \
	-pdflatex="pdflatex -interaction nonstopmode" -pvc

rapport: $(CHAPTER)
	latexmk -pdf rapport.tex -f -output-directory=.tmp \
	-pdflatex="pdflatex -interaction nonstopmode"

commit:
	git add *.tex makefile
	git commit -m "sauvegarde"

clean:
	latexmk -C rapport.tex
