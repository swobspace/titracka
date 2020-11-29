# Makefile

PROJECT=/home/wob/Projects/titracka
PUBDIR=$(PROJECT)/public/manual/

ASCIIDOCTOR_PDF_DIR = `gem contents asciidoctor-pdf --show-install-dir`
PDF_CMD = asciidoctor-pdf \
        -a pdf-stylesdir=$(PROJECT)/doc/resources/themes \
        -a pdf-style=basic \
        -a pdf-fontsdir=$(ASCIIDOCTOR_PDF_DIR)/data/fonts
HTML_CMD = asciidoctor \
	--backend html5 \
	--destination-dir $(PUBDIR)
#	--no-header-footer \

DOCUMENT = admin-manual

.PHONY: all

all: pdf html sync-images

pdf:
	$(MAKE) $(DOCUMENT).pdf
	mv $(DOCUMENT).pdf $(PUBDIR)/.
html:
	$(MAKE) $(DOCUMENT).html

sync-images:
	rsync -av ../images/. $(PUBDIR)/images/.

%.pdf: %.adoc
	$(PDF_CMD) $<

%.html: %.adoc sync-images
	$(HTML_CMD) $<

test:
	echo "$(ASCIIDOCTOR_PDF_DIR)"

