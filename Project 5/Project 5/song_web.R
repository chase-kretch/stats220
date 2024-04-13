library(tidyverse)
library(rvest)
library(lubridate)

urls <- c("https://music.apple.com/us/playlist/top-100-japan/pl.043a2c9876114d95a4659988497567be", "https://music.apple.com/us/playlist/top-100-usa/pl.606afcbb70264d2eb2b51d8dbcfa6a12",
          "https://music.apple.com/us/playlist/top-100-australia/pl.18be1cf04dfd4ffb9b6b0453e8fae8f1")

counter <- 1
song_data <- map_df(1 : length(urls), function(i){
  
  Sys.sleep(2)
  page <- read_html(urls[i])
  

  
  
  track_id <- page %>%
    html_elements(".songs-list") %>%
    html_elements("a") %>%
    html_attr("href") %>%
    .[str_detect(., "/song/")] %>%
    str_remove_all("https://(.*)/song/(.*)/")
  
  album_id <- page %>%
    html_elements(".songs-list__col.songs-list__col--tertiary") %>%
    html_elements(".songs-list__song-link-wrapper") %>%
    html_elements("a") %>%
    html_attr("href") %>%
    str_remove_all("https://(.*)/album/(.*)/")
  
  ranking <- page %>%
    html_elements(".songs-list-row__rank") %>%
    html_text2() %>%
    parse_number() ## Takes the ranking from the html
  
  song_name <- page %>%
    html_elements(".songs-list-row__song-name") %>%
    html_text2() ## Takes the song name from html
  
  song_length <- page %>%
    html_elements(".songs-list-row__controls") %>%
    html_text2() %>%
    str_remove_all("PREVIEW") %>%
    str_remove_all("\n") %>%
    ms() %>%
    as.numeric() ## Takes the song_length and converts into seconds
  
  artist_name <- page %>%
    html_elements(".songs-list__col.songs-list__col--secondary") %>%
    html_elements(".songs-list__song-link-wrapper") %>%
    html_text2()
  
  album_name <- page %>%
    html_elements(".songs-list__col.songs-list__col--tertiary") %>%
    html_elements(".songs-list__song-link-wrapper") %>%
    html_text2()
  
  

  if(i == 1){
    country = "Japan"
  } else if(i == 2){
    country = "USA"
  } else if(i == 3){
    country = "Australia"
  } ## Uses the counting variable to determine which country it is. Couldve done by reading page but this is easier to understand,
  ## Though dynamic to whatever website I decide to use, but would be hard to employ throughout the whole project anyways. (Such as my colored boxplot)
  
  my_data <- tibble(ranking, song_name, artist_name, album_name, song_length, album_id, track_id, country)

    
  
return(my_data)
  
})

saveRDS(song_data, "song_data.rds")








