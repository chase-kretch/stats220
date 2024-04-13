library(tidyverse)
library(ggplot2)
library(gganimate)
playlist_data <- readRDS("playlist_data.rds")

playlist_data <- playlist_data %>%
  mutate(IsSingleCountry = ifelse(IsSingle == "Yes", "{country} Singles", "{country} Albums"))
  # Creates a new variable that allows me to include whether or not the album was single or not but still have it based off country
playlist_data <- playlist_data %>% ## Creates a variable to have each boxplot to have its countrys colors
  mutate(Fill = ifelse(country == "Japan", "White",
                             ifelse(country == "USA", "Dark Blue", 
                                    ifelse(country == "Australia", "Yellow", "Yellow")))) %>%
  mutate(Colour = ifelse(country == "Japan", "Red",
                         ifelse(country == "USA", "Red", 
                                ifelse(country == "Australia", "Dark Green", "Dark Green"))))



playlist_data %>%
  ggplot() +
  geom_boxplot(aes(x = IsSingleCountry, y = song_length, fill = Fill, colour = Colour), alpha = 0.6) +

  labs(title = "Song length of Top 100 Songs in USA, Japan and Australia", subtitle = "Album songs vs Singles",
       fill = "Country", x = "", y = "Song Length (Seconds)") +
  scale_x_discrete(labels = c("Songs from Albums", "Songs from Singles")) +
  scale_fill_identity(guide = guide_legend(), labels=c("USA", "Japan", "Australia")) +
  scale_color_identity() +
  theme_classic() 

ggsave("song_vis.png", width = 8, height = 5, units = "in")


most_popular_albums <- playlist_data %>% ## Creates a summary of the most popular albums (repeated albums) in the dataset
  select(album_name) %>%
  group_by(album_name) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1 : 10)


  

playlist_data <- playlist_data %>%
  mutate(days = difftime(as.character(Sys.Date()) ,as.character(album_release_date), units = "days"))

playlist_data %>% ##Thought id make a animated graph because I think theyre super cool.
  ggplot() +
  geom_violin(aes(x = ranking, y = days, fill = "violet"), show.legend = FALSE) + 
  transition_states(country) +
  labs(title = "Days Since Song Release vs Country", x = "", y = "Days Since Release", subtitle = "Country: {closest_state}")

anim_save("playlistanimgg.gif")



