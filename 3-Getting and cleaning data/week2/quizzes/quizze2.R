oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "6fa2aa8904ed22fd229b",
                   secret = "56ead6d7f10c983dc3d93cb8a513879b8ffb82d1")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
#gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
#stop_for_status(req)
#content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

x <- read.fwf(
  file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))

x <- read.fwf(
  file="wksst8110.for",
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))