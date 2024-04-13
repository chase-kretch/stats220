library(tidyverse)
learning_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vR204WVLpFy7g8NMr3gTlZHcFvIjkBqrC_X3eQd6i3zdvJUh7K74wKAM2Gne6SRl1kJHApphM5D7UaL/pub?gid=1703945528&single=true&output=csv") %>%
  rename(status = 2, ### Renames all columns to more ideal names
         ideal_spaces = 3,
         enjoy_code = 4,
         weekly_code = 5,
         personal_code = 6,
         experience = 7,
         study_time = 8)
enjoy_code_mean <- learning_data$enjoy_code %>% ## Creates a mean object for enjoy_code variable
  mean()
weekly_code_mean <- learning_data$weekly_code %>% ## Same thing but for weekly code
  mean()
experience_mean <- learning_data$experience %>% ##..
  mean()



paste("Means:")
paste("Enjoy code mean:", enjoy_code_mean)
paste("Personal Code mean:",personal_code_mean)
paste("Experience mean:",experience_mean)
paste("----------------------")
paste("Maxes:")
paste("Enjoy code:", max(learning_data$enjoy_code))  ## Uses a shorter method without creating an object
paste("Personal code max:",max(learning_data$weekly_code))
paste("Experience max: ",max(learning_data$experience)) ## I tried making kind of a list/table to see the summary values.
 ## It didn't work very well but oh well..
 ## I decided to use as many as I can since they won't take up much space in the final product.
 ## Although, max is not useful for the enjoy_code data as it has a set limit of 5. 

learning_data %>% ## Bar graph of studying time
  ggplot() +
  geom_bar(aes(x = study_time))

learning_data %>% ## Bar graph of participants status, use arrow top left of graph to navigate
  ggplot() +
  geom_bar(aes(x = status))
