# RSE 2018 Shiny Workshop

To run docker image containing shiny server

```
docker run -d  -p 8788:8787 -p 3838:3838 mawds/rstudio
```

We map 3838 so we can view in external browser.
Image sets up Rprofile.site so that default interface for Shiny is
0.0.0.0:3838

Note the RunApp button doesn't seem to work properly in Firefox - the app doesn't initialise properly.   Is OK in Chromium


