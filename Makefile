# Build the artefacts required for the RSE 2018 Workshop on Shiny
#
# David Mawdsley
#

.NOTPARALLEL: sitecontent

presentationname=WorkshopSlides

contentrmd = $(shell find content/ -name '*.Rmd' -print)
contentmd = $(patsubst %.Rmd,%.md,$(contentrmd))

sourcedata = $(wildcard sourcedata/*)

.PHONEY: runrstudio stoprstudio dockerimage 

.INTERMEDIATE: $(presentationname)_annote.Rmd

all: slides site runningExample.zip

clean: cleancontent cleanrunning

site: sitecontent
	hugo

# Remove generated markdown from site 
cleancontent:
	rm  $$(find content -name "*.md" -print)


sitecontent: $(contentmd)
	
%.md: %.Rmd addlinks.sh
	./addlinks.sh $(patsubst %.md,%.Rmd,$@) $(patsubst %.md,%_gitlink.Rmd,$@) 
	cd $(dir $@) && Rscript -e "knitr::knit('$(patsubst %.md,%_gitlink.Rmd,$(notdir $@))', output='$(notdir $@)')"
	rm $(patsubst %.md, %_gitlink.Rmd,$@)

# Dummy rule we use to force the submodules SHA1 to be 
# extracted on every run
FORCE:

# This rule will detect when the commit ID of course material
# changes
#
# Based on https://www.cmcrossroads.com/article/rebuilding-when-files-checksum-changes
# This will always write the head commit of the course material
coursematerialHead.txt: FORCE
	cd coursematerial && git rev-parse  HEAD > $@  && mv $@ ..  && cd ..

# This will only write to coursematerialHead2.txt if 
# the previous run's head commit is different
coursematerialHead2.txt: coursematerialHead.txt
	$(if $(filter-out $(shell cat $@ 2>/dev/null),$(shell cat $<)),$(shell cp $< $@))


runningExample.zip: coursematerialHead2.txt
	./unwraprepo.sh
	zip -r $@ runningExample/*
	rm -r runningExample

cleanrunning:
	rm -r runningExample.zip

slides: $(presentationname).html

$(presentationname).html: $(presentationname)_annote.Rmd coursematerial/workshopFunctions.R coursematerial/gapminder.rds  .gitmodules presentstyle.css headerfooter.html
	Rscript -e "rmarkdown::render('$<', output_file='$@')"
	touch content/slides.html


$(presentationname)_annote.Rmd: $(presentationname).Rmd
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

