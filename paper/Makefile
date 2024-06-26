# Makefile for SUES-MM

# Basename of the paper
THESIS = paper
COMMITMENT = commitment
FORMAT = format

# Option for latexmk
LATEXMK_OPT = -time -file-line-error -halt-on-error -interaction=nonstopmode
LATEXMK_OPT_PVC = $(LATEXMK_OPT) -pvc

# make deletion work on Windows
ifdef SystemRoot
	RM = del /Q
	OPEN = start
else
	RM = rm -f
	OPEN = open
endif

.PHONY : all pvc view wordcount clean cleanall FORCE_MAKE

all : $(THESIS).pdf $(COMMITMENT).pdf $(FORMAT).pdf

$(THESIS).pdf : $(THESIS).tex FORCE_MAKE
	@latexmk -pdfxe $(LATEXMK_OPT) $<

$(COMMITMENT).pdf : $(COMMITMENT).tex FORCE_MAKE
	@latexmk -pdfxe $(LATEXMK_OPT) $<

$(FORMAT).pdf : $(FORMAT).tex FORCE_MAKE
	@latexmk -pdfxe $(LATEXMK_OPT) $<

pvc : $(THESIS).tex $(COMMITMENT).tex $(FORMAT).tex
	@latexmk -pdfxe $(LATEXMK_OPT_PVC) $(THESIS)
	latexmk -pdfxe $(LATEXMK_OPT_PVC) $(COMMITMENT)
	latexmk -pdfxe $(LATEXMK_OPT_PVC) $(FORMAT)

view : $(THESIS).pdf $(COMMITMENT).pdf $(FORMAT).pdf
	$(OPEN) $<

wordcount : $(THESIS).tex
	@if grep -v ^% $< | grep -q '\\documentclass\[[^\[]*en'; then \
		texcount $< -inc -char-only | awk '/total/ {getline; print "英文字符数\t\t\t:",$$4}'; \
	else \
		texcount $< -inc -ch-only   | awk '/total/ {getline; print "纯中文字数\t\t\t:",$$4}'; \
	fi
	@texcount $< -inc -chinese | awk '/total/ {getline; print "总字数（英文单词 + 中文字）\t:",$$4}'

clean :
	-@latexmk -pdfxe -c -silent $(THESIS).tex 2> /dev/null
	-@latexmk -pdfxe -c -silent $(COMMITMENT).tex 2> /dev/null
	-@latexmk -pdfxe -c -silent $(FORMAT).tex 2> /dev/null

cleanall :
	-@latexmk -pdfxe -C -silent $(THESIS).tex 2> /dev/null
	-@latexmk -pdfxe -C -silent $(COMMITMENT).tex 2> /dev/null
	-@latexmk -pdfxe -C -silent $(FORMAT).tex 2> /dev/null
