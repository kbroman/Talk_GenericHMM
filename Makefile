STEM = general_hmm

FIGS = Figs/hs.pdf Figs/ri8.pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

all: docs/$(STEM).pdf docs/$(STEM)_notes.pdf

docs/%.pdf: %.pdf
	cp $^ $@

$(STEM).pdf: $(STEM).tex header.tex $(FIGS)
	xelatex $^

Figs/%.pdf: R/%.R
	cd R;R CMD BATCH $(R_OPTS) $(<F)

$(STEM)_notes.pdf: $(STEM)_notes.tex header.tex $(FIGS)
	xelatex $<
	pdfnup $@ --nup 1x2 --no-landscape --paper letterpaper --frame true --scale 0.9
	mv $(STEM)_notes-nup.pdf $@

$(STEM)_notes.tex: $(STEM).tex Ruby/createVersionWithNotes.rb
	Ruby/createVersionWithNotes.rb $< $@

clean:
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb
