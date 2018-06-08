# Build the artefacts required for the RSE 2018 Workshop on Shiny
#
# David Mawdsley

presentationname=WorkshopSlides

$(presentationname).html: $(presentationname).Rmd
	Rscript -e "rmarkdown::render('$<')"

present: $(presentationname).html
	chromium-browser $< &

dockerimage: Dockerfile	
	docker build . -t mawds/rstudio

coursematerial/gapminder.csv: createData.R
	Rscript $<


