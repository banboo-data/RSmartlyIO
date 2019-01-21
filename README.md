RSmartlyIO
========================================================

[![RSmartlyIO Cran Release](https://www.r-pkg.org/badges/version-last-release/RSmartlyIO)](https://cran.rstudio.com/web/packages/RSmartlyIO/index.html) [![RSmartlyIO Cran Downloads](https://cranlogs.r-pkg.org/badges/grand-total/RSmartlyIO)](https://cran.rstudio.com/web/packages/RSmartlyIO/index.html)


RSmartlyIO is a license cost free open source project by [@jburkhardt](https://github.com/jburkhardt).

### Loading Facebook and Instagram Advertising Data from Smartly.io into R

R Package which aims at loading **Facebook** and **Instagram** advertising data from [Smartly.io](https://app.smartly.io) into R.  
Smartly.io is an online advertising service that enables advertisers to display commercial ads on social media networks.  
The package offers an interface to query the Smartly.io API and loads data directly into R for further data processing and data analysis.

### Installation

The package can b isntalled from CRAN

```R
install.packages("RSmartlyIO")
```

or directly from this Github repository with:

```R
require(devtools)
install_github('rstats-lab/RSmartlyIO')
```

### Usage
```R
data <- getSmartlyData(start = "2019-01-01",
                       end = "2019-01-10",
                       date = "date",
                       accountID="*****************",
                       accountInfo = F,
                       campaignStructure = c("campaign_name", "campaign_fb_id"),
                       billing = c("bid.optimization_goal", "bid.billing_event"),
                       targeting = c("targeting.geo_locations.countries"),
                       creative = c("creative_meta.call_to_action"),
                       #facebook = "age",
                       apiToken="************************************",
                       attribtuion = "28d",
                       metrics = c("impressions","clicks"))
```

### Documentation

The official package documentation can be found here: http://rstats-lab.github.io/RSmartlyIO/
