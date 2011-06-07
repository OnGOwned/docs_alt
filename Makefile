PROJECT = centaurus
TOPLEVEL_DOC = index.txt 
HTMLPAGE = $(TOPLEVEL_DOC:.txt=.html)
RESOURCE_FILES = /etc/asciidoc/

docdir = /usr/local/share/doc/$(PROJECT)
DESTDIR =

A2X = a2x
INSTALL = install
INSTALL_DATA = $(INSTALL) -m 644

.PHONY: all install clean

all: $(HTMLPAGE)

%.html: %.txt
	$(A2X) -d book -f xhtml -a lang=ru \
	  --icons -r $(RESOURCE_FILES) -r ./ \
	  --xsltproc-opts='--stringparam toc.max.depth 2' \
	  $<

chunked: $(TOPLEVEL_DOC)
	$(A2X) -d book -f chunked -a lang=ru \
	  --icons -r /etc/asciidoc/ -r ./ \
	  --xsltproc-opts='--stringparam toc.max.depth 2' \
	  $<

pdf: $(TOPLEVEL_DOC)
	$(A2X) --fop --fop-opts='-c fop.xconf' -d book -f pdf -a lang=ru \
	  --xsltproc-opts=' \
	  --stringparam toc.max.depth 2 \
	  --stringparam title.font.family "Liberation Sans" \
	  --stringparam body.font.family "Liberation Sans" \
	  --stringparam monospace.font.family "Liberation Mono"' \
	  $<

install: all
	$(INSTALL) -d $(DESTDIR)$(docdir)/images/icons/
	$(INSTALL_DATA) $(HTMLPAGE) $(DESTDIR)$(docdir)/
	$(INSTALL_DATA) docbook-xsl.css $(DESTDIR)$(docdir)/
	$(INSTALL_DATA) images/*.png $(DESTDIR)$(docdir)/images/
	$(INSTALL_DATA) images/icons/* $(DESTDIR)$(docdir)/images/icons/

clean:
	$(RM) -r index.xml $(HTMLPAGE) docbook-xsl.css images index.chunked index.fo index.pdf *~
