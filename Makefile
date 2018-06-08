# Build the artefacts required for the RSE 2018 Workshop on Shiny
#
# David Mawdsley

presentationname=WorkshopSlides

$(presentationname).html: $(presentationname).Rmd
	Rscript -e "rmarkdown::render('$<')"


