CHAPTER  := $(wildcard *.tex)
TEXFILE		= rapport
PDFLATEX	= latexmk -quiet
TEXFLAGS	= -interaction nonstopmode
RDIR      = ./src
FIGDIR    = ./img

# list R files
RFILES := $(wildcard $(RDIR)/*.R)
# pdf figures created by R
PDFFIGS := $(wildcard $(FIGDIR)/*.pdf)
# indicator files to show R file has run
OUT_FILES := $(RFILES:.R=.Rout)
# indicator files to show pdfcrop has run

all: $(TEXFILE).pdf $(OUT_FILES)

preview: $(TEXFILE).tex
	$(PDFLATEX) -pvc $<

# compile main tex file and show errors
$(TEXFILE).pdf: $(TEXFILE).tex $(OUT_FILES)
	$(PDFLATEX) $(TEXFILE)

# run every r file
$(RDIR)/%.Rout: $(RDIR)/%.R
	R CMD BATCH --vanilla $<


# run r files
R: $(OUT_FILES)

view: $(TEXFILE).pdf
	open -a Skim $(TEXFILE).pdf


commit:
	git add *.tex makefile schema/*.tex
	git commit -m "sauvegarde"

clean:
	latexmk -C $(TEXFILE)

.PHONY: all clean
