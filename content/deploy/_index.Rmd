---
title: "Deploying Shiny apps"
chapter: true
weight: 40
pre: "<b>5. </b>"
---
### Chapter 5

# Deploying Shiny apps

If we want to use our app out of R Studio we will need to deploy it to a Shiny Server.  There are a number of options for doing this:

* Host a [Shiny Server instance](https://www.rstudio.com/products/shiny/shiny-server/).   Shiny Server comes in both open source and commercial editions.   
   *See also [Shinyproxy](https://www.shinyproxy.io/) to extend the features of the open source version (authentication, containerisation)
* Deploy the app to shinyapps.io
   * Free and paid for versions

Setting up a Shiny Server is beyond the scope of this workshop.   Instead we'll deploy our apps to shinyapps.io

Create an account on shinyapps.io via [https://www.shinyapps.io/admin/#/signup]  You can do this using a Google or Github account, or using a username/password.

Having created an account, we can deploy the app directly from R Studio. To do this, click the blue publish icon (to the right of the run button).   You will be prompted to enter your account token.  This can be obtained from the dashboard for your shinyapps.io account.  Click the account menu (on the left) then select tokens.  Click "show", "show secret" and then copy the token to the clipboard.  This can be pasted into the box in Studio.

Having connected your account, check that the `app.R` file and all its dependencies (`plottingFunctions.R` and `gapminder.rds`) are selected and then choose publish.  The app will be packaged and uploaded to shinyapps.io

