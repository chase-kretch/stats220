library(tidyverse)
url1 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S123/zoom_data/participants3.csv"
url2 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S123/zoom_data/participants5.csv"

csv3 <- read_csv(url1)
csv10 <- read_csv(url2)

count(distinct(csv3, private_name))

combined <- rbind(csv3, csv10) 

round(mean(combined$duration_minutes), 1)

combined <- combined %>%
  group_by(private_name) %>%
  summarise(n = sum(duration_minutes))


combined <- combined %>%
  group_by(date_lecture) %>%
  summarise(n = n())