library(tidyverse)
library(rvest)

page_to_scrape <- "https://ccle.ucla.edu/pluginfile.php/2877809/mod_resource/content/2/basic_table.html"
wp <- read_html(page_to_scrape)

wp %>%
  html_node(xpath = "//*")
xp <- "/html/body/table/tbody/tr[3]/td[3]/a"

wp %>% 
  html_node(xpath = xp) ->
  joe_age_node
joe_age_node

# {xml_missing}
# <NA>
# We get this result because tbody (table body) is in the html code but not in the original source code
# R & rvest don't figure out table body issues
# Solution - remove tbody tag from your code

xp <- "/html/body/table/tr[3]/td[3]/a"

wp %>% 
  html_node(xpath = xp) ->
  joe_age_node
joe_age_node

# Now that we have our node, we can pull stuff out of it
html_text(joe_age_node) # all text
html_name(joe_age_node) # anchor tag
html_attr(joe_age_node, "href") # what attribute you're looking for (in this its hypertext reference)
html_attrs(joe_age_node) # all attributes

joe_age_node %>%
  html_text() %>%
  as.numeric() ->
  joe_age
joe_age
# [1] 100

# Emmett Brown's age:
xp <- "//*[@id=\"eba\"]" # this is uniquely identified by its id attribute
wp %>%
  html_node(xpath = xp) %>%
  html_attr("href") ->
  docs_page
docs_page
# [1] "https://www.imdb.com/title/tt0088763/"

wp <- read_html(docs_page)
xp_title <- "//*[@id=\"title-overview-widget\"]/div[1]/div[2]/div/div[2]/div[2]/h1/text()"
wp %>%
  html_node(xpath = xp_title) %>%
  html_text() ->
  title
title

xp_score <- "//*[@id=\"title-overview-widget\"]/div[1]/div[2]/div/div[1]/div[1]/div[1]/strong/span"
wp %>%
  html_node(xpath = xp_score) %>%
  as.numeric() ->
  score
score

url <- 'https://www.behindthename.com'
btn <- read_html(url)
btn %>%
  html_nodes(xpath = '//*[@id="popbody"]/tr/td/a') %>% 
  # use html_nodes and get one name's id '//*[@id="popbody"]/tr[9]/td[5]/a' then remove the indices [9] & [5]
  html_text()

# To get a table all at once: we would pass html_table() instead of html_text()
simpsons_wiki <- "https://en.m.wikipedia.org/wiki/List_of_The_Simpsons_episodes"
simpsons_wp <- read_html(simpsons_wiki)
simpsons_wp %>%
  html_node(xpath = '//*[@id="mw-content-text"]/table[13]) %>%
  html_table() ->
  season30
season30
