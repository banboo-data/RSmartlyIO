## RSmartlyIO

### Loading Facebook and Instagram Advertising Data from Smartly.io into R

R Package which aims at loading **Facebook** and **Instagram** advertising data from [Smartly.io](https://app.smartly.io) into R.  
Smartly.io is an online advertising service that enables advertisers to display commercial ads on social media networks.  
The package offers an interface to query the Smartly.io API and loads data directly into R for further data processing and data analysis.

### Installation

```
require(devtools)
install_github('rstats-lab/RSmartlyIO')
```

### Usage
```
data <- getSmartlyData(start = "2016-03-01",
                       end = "2016-03-02",
                       date = "date",
                       accountID="*****************",
                       accountInfo = F,
                       campaignStructure = c("campaign_name", "campaign_fb_id"),
                       billing = c("bid.optimization_goal", "bid.billing_event"),
                       targeting = c("targeting.geo_locations.countries"),
                       creative = c("creative_meta.call_to_action"),
                       #facebook = "age",
                       apiToken="************************************",
                       metrics = c("impressions","clicks"))
```

### Documentation

The official package documentation can be found here: http://rstats-lab.github.io/RSmartlyIO/
