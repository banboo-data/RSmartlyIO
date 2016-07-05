\name{RSmartlyIO}
\alias{RSmartlyIO}
\title{Loading Facebook and Instagram Advertising Data from Smartly.io}
\description{Aims at loading \strong{Facebook} and \strong{Instagram} advertising data from \href{https://app.smartly.io}{Smartly.io} into R.
            Smartly.io is an online advertising service that enables advertisers to display commercial ads on social media networks.
            The package offers an interface to query the Smartly.io API and loads data directly into R for further data processing and data analysis.}

\examples{
\dontrun{
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
}
}

\author{
Johannes Burkhardt <johannes.burkhardt@gmail.com>
\url{https://github.com/rstats-lab/RSmartlyIO}
}

\keyword{ ~Facebook }
\keyword{ ~Instagram }
\keyword{ ~Smartly.io }
