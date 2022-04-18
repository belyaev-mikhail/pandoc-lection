all: $(shell basename $(CURDIR)).pdf images

fast: $(shell basename $(CURDIR)).pdf

eps_images := $(patsubst %.svg,%.eps,$(wildcard *.svg))
jpg_images := $(wildcard *.jpg)
png_images := $(wildcard *.png)

images: $(eps_images) $(jpg_images) $(png_images)

%.eps: %.svg
	inkscape $*.svg -o $*.eps

%.pdf: main.md $(eps_images)
	pandoc -t beamer+smart \
		--pdf-engine=lualatex \
		--pdf-engine-opt=-shell-escape \
		--template=../shared/beamer.template \
		-f markdown-blank_before_blockquote \
		-f markdown+inline_notes \
		-V lang:russian \
		-V fontenc:T2A \
		-V theme:metropolis \
		-V colortheme:rose \
		-V classoption:t \
		-V shorttitle:"Static analysis 101" \
		-V graphics \
		-s main.md -o $@
	
