# RSE 2018 Shiny Workshop

This repo contains the website,  slides and other material for the RSE 2018 Shiny Workshop.

The website for the workshop is at https://uomresearchit.github.io/RSE18-shiny-workshop/

The code required for the running example is in a separate repository at: https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials . This is cloned to each user's (virtual) machine.

Each step of the exercises is a separate tagged commit in this repository.  These commits are linked to the relevant github commit page on the workshop slideshow and on the website.

## Build/modification process

To edit the webpage or slide show, edit the relavant `.Rmd` file.  **Do not edit the `.md` files - these are automatically generated**.  `make` will build the site and slideshow as required.  The build process for the `.Rmd` files is:

1. Resolve links of the form `[git:tagname]()` to the appropriate page on github.  This step will fail by design if there are any unresolved links (i.e. there isn't a commit with tag "tagname" in the coursematerial repository)

2. The `.Rmd` files will be "knitted" to `.md` files ready for Hugo.  R code snippets within them will be executed and the output included in the `.md` file.

`hugo serve` will let you locally preview the changes.  `make cleancontent` will delete all the generated `.md` files.  It's safer to stop the local server before running this and regenerating the content if needed; otherwise the left hand menu isn't generated reliably.

Push the repo to github to deploy.

## Modifying the exercises

The aim is to keep a clean commit history in the workshop-materials repoistory, with each commit corresponding to a solution to an exercise, or a check point in the lesson.   If you find a bug in the code, or need to modify something, we rewrite the history to make it look like the bug was never there. The basic procedure is:

1. Checkout the commit where the issue is introduced
2. Create a new branch `git checkout -b bugfix`
3. Fix the bug
4. `git rebase bugfix master`
5. `git branch -d bugfix` (At this point you should have a linear sequence of commits, including the extra commit where the bug was fixed, plus a (buggy) branch with the tagged commits)
5. `git rebase -i --root` to interatively rebase the (good) branch.  Squash the bugfix commit with its parent
6. Re-tag the commits on the new branch (`git tag -d tagname`, `git tag tagname commitid`).  This is manual at the moment (TODO automate this - should be possible to match on commit messages, as these will be identical on the buggy and good branch)
7. Check you have a linear commit history with (all) the commits tagged
7. Regenerate the website / slides to use the new commitids: `make cleancontent`, `make`
8. Force push the coursematerial website (at this point the old commits will no longer be visible in the log since nothing points to them)
9. Push the main repository.

### Editing the gapminder data

The gapminder data used in the course is different from that included in the [gapminder R package](https://cran.r-project.org/web/packages/gapminder/index.html).  The data in this course has values for every year rather than the 5 year intervals uses in the gapminder package.  The `createData.R` script pulls together the source data (downloaded from the gapminder website), deals with standardising country names, etc.

The data included also contains total fertility rate and subregion - I ended up not using these in the course, but I've left them in in case we use them when we extend the workshop to a Research IT training course.

## Old notes on Docker image

Early work was done in a Docker image - this is no longer needed, as it was more space-efficient to install RStudio etc directly in the virtual machine supplied by the organisers.  Build instructions for this, and a test script are in `vminstall`

The Docker image can be built with `make dockerimage`
The Docker image can be started/stoped with `run|stoprstudio`
The slide deck will be compiled and opened with `make present`

If running the Docker image, connect to `localhost:8787`, username/password: rstudio/rstudio

We also map port 3838 so we can view Shiny apps in the external browser.

Note the RunApp button doesn't seem to work properly in Firefox - the app doesn't initialise properly.   Is OK in Chromium.


