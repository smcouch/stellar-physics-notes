BASE = stellar-notes
COMPILE = pdflatex
OPS =  --file-line-error --synctex=1
RM = rm -f

CHAPTERS = 	frontmatter \
			introduction \
			equations \
			convection \
			Lane-Emden \
			eos \
			radiation \
			plasma \
			atmosphere \
			star-formation \
			nuclear \
			main-sequence \
			post-main-sequence \
			perturbations \
			binaries \
			technical-notes \
			prelim \
			kinetic

TEX_SRC = $(foreach chap, $(CHAPTERS), $(wildcard $(chap)/*.tex))

FIGURES = 	convection/figs/convection-1.jpg \
			convection/figs/convection-2.jpg \
			convection/figs/convective.pdf \
			convection/figs/turbulence-maker.pdf \
			Lane-Emden/figs/LE_all.pdf \
			radiation/figs/intensity-schematic.pdf \
			plasma/figs/scattering.pdf \
			plasma/figs/mean-free-path.pdf \
			plasma/figs/shear-diagram.pdf \
			atmosphere/figs/spectral_distribution.pdf \
			nuclear/figs/coulomb_integrand.pdf \
			binaries/figs/Roche.pdf \
			perturbations/figs/eulerian.pdf \
			perturbations/figs/lagrangian.pdf \
			technical-notes/figs/steepening.pdf \
			technical-notes/figs/piston.pdf

BIBS = bibs/stellar.bib

default: $(BASE).pdf

handout: sample-handout.pdf

$(BASE).pdf: $(BASE).tex $(TEX_SRC) $(FIGURES) $(BIBS)
	git rev-parse --short=8 HEAD > git-info.tex
	$(COMPILE) $(OPS) $(BASE).tex
	bibtex $(BASE).aux
	$(COMPILE) $(OPS) $(BASE).tex
	$(COMPILE) $(OPS) $(BASE).tex

quick: $(BASE).tex $(TEX_SRC) $(FIGURES) $(BIBS)
	git rev-parse --short=8 HEAD > git-info.tex
	$(COMPILE) $(OPS) $(BASE).tex

sample-handout.pdf: sample-handout.tex $(TEX_SRC) $(FIGURES) $(BIBS)
	git rev-parse --short=8 HEAD > git-info.tex
	$(COMPILE) $(OPS) sample-handout.tex
	bibtex sample-handout.aux
	$(COMPILE) $(OPS) sample-handout.tex
	$(COMPILE) $(OPS) sample-handout.tex

clean:
	$(RM) *.aux *.log *.dvi *.bbl *.blg *.toc *.log *.synctex* *.out

realclean: clean
	$(RM) $(BASE).pdf
