

album_ids <- song_data$album_id %>% 
  unique() ## Gets all unique album ids as the rest are redundant

album_data <- map_df(1: length(album_ids), function(i){ ## Iterates through function(i) with i as a iterative variable
  Sys.sleep(2)
  url <- paste0("https://music.apple.com/album/", album_ids[i]) ##album_ids[i] = album_id at correct value and joins them to create one url
  
  page <- read_html(url)
  
  album_info <- page %>%
    html_elements(".footer-body") %>%
    html_elements(".description") %>%
    html_text() %>%
    str_split("\n") %>%
    unlist()
  
  album_songs <- str_extract(album_info[2], "\\d+") ##Gets the first digits in the album info[2]
  
  album_length <- str_extract(album_info[2], "\\d+ minutes")  ##Gets the minute value from albuminfo[2]
  
  album_release_date <- album_info[1] %>%
    mdy() ## Uses lubriate to turn mdy format to date format
  album_id = album_ids[i]
  my_data <- tibble(album_release_date, album_id, album_songs, album_length )
return(my_data)
})

album_data <- album_data %>%
  mutate(IsSingle =  ifelse(album_songs == 1, "Yes", "No")) ## Creates a new variable which determines whether or not a album is a single or not

playlist_data <- inner_join(song_data, album_data, by="album_id") ## Inner joins song_data and album_data  by album_id (removes excess)

saveRDS(playlist_data, "playlist_data.rds")

