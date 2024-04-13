library(tidyverse)
library(jsonlite)

query <- "https://itunes.apple.com/search?term=lofi&media=music&limit=200"
response <- fromJSON(query)


my_playlist <- response$results %>%
  rename(artist_name = 6,
         album = 7,
         song_name = 8,
         genre = 30,
         song_length = 27,
         release_date = 20,
         explicit = 22) %>%

  filter(str_detect(str_to_lower(explicit),"not")
       ) %>%
  mutate(format_date = as.Date(release_date)) %>%
  mutate(format_seconds = song_length / 1000) %>%
  arrange(desc(format_date)) %>%
  select(song_name, artist_name, album, genre, format_date, format_seconds) %>%
  slice(1 : 20) %>%
  mutate(long_or_short = ifelse(format_seconds > 180, "Long", "Short"))
view(my_playlist)
write_csv(my_playlist, "my_playlist.csv")
my_playlist %>%
  group_by(long_or_short) %>%
  summarise(mean_song_length = mean(format_seconds))

my_playlist %>%
  ggplot() +
    geom_bar(aes(x = long_or_short, fill = long_or_short)) +
    labs(title = "Songs in my playlist that are long vs short", x = "Long or Short")
