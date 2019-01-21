#' @title Get Smartly.io Data
#'
#' @description getSmartlyData posts the query and downloads the data.
#' The data are retrieved from the API as a dataframe.
#'
#' @param start Beginning of date range. Format: "2019-01-01"
#' @param end End of date range. Format: "2019-01-10"
#' @param date Date aggregation level. One out of date, year, month, weekofyear, weekday
#' @param accountID Smartly.io Account ID. Input as character: "1234abcdefg5678"
#' @param accountInfo Account Information. TRUE/FALSE
#' @param campaignStructure Campaign Information Selection. Vector with multiple arguments out of: campaign_name, campaign_fb_id, adgroup_name, adgroup_fb_id, name, id, fb_objective, campaign_start_date
#' @param billing Billing Information Selection. Vector with multiple arguments out of: bid.optimization_goal, bid.billing_event
#' @param targeting Targeting Settings of Campaigns. Vector with multiple arguments out of: targeting.geo_locations.countries, targeting.geo_locations.cities, targeting.genders, targeting.age_min, targeting.age_max, targeting.interests, targeting.behaviors, targeting.custom_audiences, targeting.excluded_custom_audiences, targeting.connections, targeting.user_os, targeting.user_device, targeting.page_types
#' @param creative Creative/Ad Characteristics. Vector with multiple arguments out of: creative_meta.call_to_action, creative_meta, creative_meta.type, creative_meta.post_type, creative_meta.name, creative_meta.picture, creative_meta.post_fb_id, creative_meta.post_fb_link, creative_meta.text, creative_meta.title, creative_meta.link, creative_meta.url_tags
#' @param facebook Facebook Settings. One argument out of: age, country, gender, age_gender, placement, cross_device, region, hourly_stats_aggregated_by_advertiser_time_zone, hourly_stats_aggregated_by_audience_time_zone
#' @param apiToken API Token. Character. Usually the API token is provided within the Smartly.io web interface or by the account manager.
#' @param metrics Metrics. Note: There are more metrics available. See the reporting section in the smartly.io interface. Vector with multiple argumets out of: impressions, ctr, cpm, cpc, spent, conversions, inline_link_clicks, clicks, cpa, reach, frequency, roi, revenue, social_impressions, social_clicks, website_clicks, newsfeed_clicks, deeplink_clicks, app_store_clicks, call_to_action_clicks, inline_post_engagement
#' @param attribution Attribtuion Time Window, defaults to 28 days. One of: "1d","7d" or "28d".
#' @export
#' @return Dataframe
#'
getSmartlyData <- function(start,
                            end,
                            date = "date", #one out of date,year,month,weekofyear,weekday
                            accountID,
                            accountInfo = F,
                            campaignStructure = NULL, #vector (multiple): campaign_name, campaign_fb_id, adgroup_name, adgroup_fb_id, name, id, fb_objective, campaign_start_date
                            billing = NULL, #vector (multiple): bid.optimization_goal, bid.billing_event
                            targeting = NULL, #vector (multiple): targeting.geo_locations.countries, targeting.geo_locations.cities, targeting.genders, targeting.age_min, targeting.age_max, targeting.interests, targeting.behaviors, targeting.custom_audiences, targeting.excluded_custom_audiences, targeting.connections, targeting.user_os, targeting.user_device, targeting.page_types
                            creative = NULL, #vector (multiple): creative_meta.call_to_action, creative_meta, creative_meta.type, creative_meta.post_type, creative_meta.name, creative_meta.picture, creative_meta.post_fb_id, creative_meta.post_fb_link, creative_meta.text, creative_meta.title, creative_meta.link, creative_meta.url_tags
                            facebook = NULL, #one of (single): age, country, gender, age_gender, placement, cross_device, region, hourly_stats_aggregated_by_advertiser_time_zone, hourly_stats_aggregated_by_audience_time_zone
                            attribution = "28d",
                            apiToken,
                            metrics){
        #attribution window
        switch(attribution,
               "1d" = attribution <- "%7B%22click%22%3A%221d_click%22%2C%22view%22%3Afalse%7D",
               "7d" = attribution <- "%7B%22click%22%3A%227d_click%22%2C%22view%22%3Afalse%7D",
               "28d" = attribution <- "%7B%22click%22%3A%2228d_click%22%2C%22view%22%3Afalse%7D")
        #build metrics query
        metrics <- paste(metrics, sep="", collapse="%2C")
        #build groupby query
        #if account Info
        if(accountInfo){
          groupby <- c(date,"account_name","creative_meta.page_name")
          groupby <- paste(groupby, sep="", collapse="%2C")
        } else{
          groupby <- date
        }
        #if campaign structure
        if(!is.null(campaignStructure)){
          groupby <- c(groupby, campaignStructure)
          groupby <- paste(groupby, sep="", collapse="%2C")
        }
        #if billing
        if(!is.null(billing)){
          groupby <- c(groupby, billing)
          groupby <- paste(groupby, sep="", collapse="%2C")
        }
        #if targeting
        if(!is.null(targeting)){
          groupby <- c(groupby, targeting)
          groupby <- paste(groupby, sep="", collapse="%2C")
        }
        #if creative
        if(!is.null(creative)){
          groupby <- c(groupby, creative)
          groupby <- paste(groupby, sep="", collapse="%2C")
        }
        if(!is.null(facebook)){
          facebook <- paste("fb",facebook,sep="%3A")
          groupby <- c(groupby, facebook)
          groupby <- paste(groupby, sep="", collapse="%2C")
        }
        groupby <- paste(groupby, "&meta=account_id%2Ccampaign_id", sep="")
        #build url
        url <- paste("https://stats-api.smartly.io/api/v1.2/stats?account_id=",#old url: "https://api.smartly.io/v1.0/stats?account_id=",
                     accountID,
                     "&stats=",
                     start,
                     "%3A",
                     end,
                     "&attribution=",
                     attribution,
                     "&metrics=",
                     metrics,
                     "&filters=%5B%5D&filter_type=%24and&groupby=",
                     groupby,
                     "&format=csv&csv_col_separator=;&csv_dec_separator=,&api_token=",
                     apiToken, sep="")
        data <- RCurl::getURL(url)
        data <- utils::read.csv2(textConnection(data),sep=";",header=T)#[-1,]
        data
}
