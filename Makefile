# Build the artefacts required for the RSE 2018 Workshop on Shiny
#
# David Mawdsley
presentationname=WorkshopSlides
notesname=courseNotes

.PHONEY: runrstudio stoprstudio dockerimage
.INTERMEDIATE: $(presentationname)_annote.Rmd $(notesname)_annote.Rmd
sourcedata = $(wildcard sourcedata/*)

contentrmd = $(shell find content/ -name '*.Rmd' -print)
contentmd = $(patsubst %.Rmd,%.md,$(contentrmd))

sitecontent: $(contentmd)
	
%.md: %.Rmd
	Rscript -e "knitr::knit('$(patsubst %.md,%.Rmd,$@)', output='$@')"

all: slides notes


notes: $(notesname).md

slides: $(presentationname).html

$(presentationname).html: $(presentationname)_annote.Rmd coursematerial/plottingFunctions.R coursematerial/gapminder.rds  .gitmodules
	Rscript -e "rmarkdown::render('$<', output_file='$@')"

$(notesname).md: $(notesname)_annote.Rmd
	Rscript -e "knitr::knit('$<', output='$@')"

$(presentationname)_annote.Rmd: $(presentationname).Rmd
	./addlinks.sh $< $@

$(notesname)_annote.Rmd: $(notesname).Rmd
	./addlinks.sh $< $@

present: $(presentationname).html
	chromium-browser $< &

dockerimage: Dockerfile	
	docker build . -t mawds/rstudio

coursematerial/gapminder.rds: createData.R $(sourcedata) 
	Rscript $<

runrstudio: 
	docker run --rm -d --name rstudio -p 8787:8787 -p 3838:3838  -v "$$(pwd)/coursematerial:/home/rstudio/coursematerial" -e USERID=$UID  mawds/rstudio

stoprstudio:
	docker stop rstudio

