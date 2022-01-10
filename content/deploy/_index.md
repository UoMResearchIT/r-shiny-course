---
title: "Deploying Shiny apps"
chapter: true
weight: 40
pre: "<b>5. </b>"
---
### Chapter 5

# Deploying Shiny apps

If we want to use our app out of R Studio we will need to deploy it to a Shiny Server.  There are a number of options for doing this:

* (UoM staff/students only) Host the app on Research IT's pilot Shiny Server
* Host a [Shiny Server instance](https://www.rstudio.com/products/shiny/shiny-server/).   Shiny Server comes in both open source and commercial editions.   
* Deploy the app to [shinyapps.io](https://www.shinyapps.io)
   * Free and paid for versions

Setting up a Shiny Server is beyond the scope of this workshop (though there are some brief notes on the options for doing this in [going further]({{< ref "goingfurther" >}}).   


## Deploying apps using the pilot Shiny Server

Research IT is running a Shiny app hosting service pilot.  This allows you to 
deploy public Shiny apps on a University hosted machine.   We have also provided
an R package to make deployment of apps easier.   

To use this service you will need to request access from david "dot" mawdsley@manchester.ac.uk

Having obtained access, you will need to install our "shinysender" package.
This isn't on CRAN, so you will first need to install the "devtools" package
if you don't already have it:


```r
install.packages("devtools")  # If you don't already have devtools installed
devtools::install_github("UoMResearchIT/r-shinysender")
```

You then need to set two environment variables to let R know your UoM username
and the name of the server you wish to deploy your app to:



```r
Sys.setenv(SHINYSENDER_SERVER="shiny.its.manchester.ac.uk")  
# Your username is your UoM login
Sys.setenv(SHINYSENDER_USER="alice")
```

(To avoid having to do this each time you start R, you could set these in your
`.Rprofile` or `.Renviron` file)

Once you have performed these steps, check that your working directory contains
your Shiny app (the working directory is displayed above the console in RStudio,
or use `getwd()` to display it).  

You can then deploy your app by selecting "Addins" from the toolbar, and choosing "Upload app"

{{% notice info %}}
The first time you do this you may be prompted to update/install the miniUI 
package.  
{{% /notice %}}

You will then be prompted for your UoM password, to connect to the server.

You app wil then be "bundled" and uploaded to the remote server.  This will 
deploy the app into an environment with the same versions of packages as on 
your local machine.  (The first time you deploy an app it will take several 
minutes to download and compile the packages.  Subsequent deployments cache
the packages, and so should be much qucker).

If you want to update your app, simply upload it again.

Your app will be deployed to https://shiny.its.manchester.ac.uk/username/appname

Further details of how to use the service are [here](https://github.com/UoMResearchIT/r-shinysender/blob/master/README.md)






## Deploying apps using shinyapps.io

This section describes how to deploy an app to 
[shinyapps.io](https://www.shinyapps.io).  This is a service provided by RStudio.
The free tier offers hosting for a limited number of applications, with a limited
amount of compute time per month (i.e time yout apps are being used).  Higher "tiers" of service can be paid for, which relax these restrictions.


{{% notice info %}}
There is an issue with the package versions installed on the machines in G11.  Before linking your shinyapps.io account to Rstudio, you will need to type `options(rsconnect.check.certificate = FALSE)` into the R console.
{{% /notice %}}


Create an account on shinyapps.io via https://www.shinyapps.io/admin/#/signup  You can do this using a Google or Github account, or using a username/password.

Having created an account, we can deploy the app directly from R Studio. To do this, click the blue publish icon (to the right of the run button).  You may be prompted to install newer versions of some R packages; you should do this if prompted.

You will be prompted to enter your account token.  This can be obtained from the dashboard for your shinyapps.io account.  Click the account menu (on the left) then select tokens.  Click "show", "show secret" and then copy the token to the clipboard.  This can be pasted into the box in Studio.

Having connected your account, check that the `app.R` file and all its dependencies (`plottingFunctions.R` and `gapminder.rds`) are selected and then choose publish.  The app will be packaged and uploaded to shinyapps.io.  The deployment process automatically handles packaging the libraries we've used in our app.


{{% notice info %}}
If you are using a university machine you may find that the deployment fails.  If this happens, first check that your working directory is the one containing your `app.R` file (the working directory is visible above the console window.  You can change it by navigating to the appropriate directory using the "Files" tab in the lower right, and then selecting "More", "Set as working directory).

Having done this, type the following commands in the console window:


```r
options(rsconnect.check.certificate = FALSE)
rsconnect::deployApp()
```

This will deploy the app manually.
{{% /notice %}}



