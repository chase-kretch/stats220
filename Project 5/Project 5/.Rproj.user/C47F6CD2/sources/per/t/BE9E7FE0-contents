library(tidyverse)
library(gganimate)
email_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSVDJ6T_d5r1x_tcS3TR7xxBDOvbh_nDp4UPBeKwM564K0y-tmHuKYefdOS13Jm6c2DwACyJ9zpTrIO/pub?gid=0&single=true&output=csv")


my_data <- email_data %>%
  mutate(string_count = str_count(email_body)) %>% # Create a new string_count column
  mutate(good_sentiment_body = ifelse(sentiment_body >= 0, "Yes", "No")) %>% # Checks whether the body is of good sentiment
  mutate(good_sentiment_subject = ifelse(sentiment_subject >= 0, "Yes", "No")) %>% # Same for the title, though less useful as you can barely tell from such little words realistically
  arrange(desc(string_count)) %>%
  mutate(contains_piazza = ifelse(str_detect(str_to_lower(email_subject),"piazza"), "Yes", "No")) # Checks for posts that are from piazza as that is a large portion of my data that could be studied
# 
# april_data <- email_data %>% I played around with a lot of stuff here seeing if I could get two datasets and use them to make an animation.
#   filter(str_detect(str_to_lower(email_month), "apr")) %>% I wasnt able to though as I couldn't figure out how to select the sames.
#   select(email_month, email_day) %>%
#   count(email_day)
# march_data <- email_data %>%
#   filter(str_detect(str_to_lower(email_month), "mar")) %>%
#   select(email_month, email_day) %>%
#   count(email_day)
# Most of the stuff I did was deleted before I saw you were meant to keep it sorry.








weekday_data <- my_data %>%
  count(email_day) # Creates a dataset of just the email day and the amount of emails that day for a bar graph
x <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

refined_weekday_data <- weekday_data %>% #Recreates it into a dataframe since it gives me issues without doing this
  slice(match(x, email_day)) #Puts it in weekday order for readability

refined_weekday_data$email_day <- factor(refined_weekday_data$email_day, levels = refined_weekday_data$email_day) 
# ^^^ Learnt some code from the internet to get ggplot to not order alphabetically (lost my mind over this)
 
# Displays a bar graph comparing the email date and the number of emails received
  ggplot(refined_weekday_data,aes(x = email_day, y = n, fill = email_day)) +
  geom_col() +
  labs(title = "Weekday vs Number of Emails Sent", x = "Weekday", y = "Number of Emails", subtitle = "The middle & start of the week tends to have the most emails sent",
       fill = "Weekday")
ggsave("barchartggplot.png")



# Displays a density graph to show a relationship between string_count and sentiment of the body
my_data %>%
  ggplot() +
  geom_density(aes(x = string_count, fill = good_sentiment_body, alpha = 0.5)) +
  labs(title = "Email body sentiment vs String Count", x = "String Count", y = "Density", 
       subtitle="Good sentiment emails are usually shorter,\nwhile bad sentiment usually are more dispersed/longer",
       fill = "Sentiment") +
  scale_fill_discrete(labels=c('Bad Sentiment', 'Good Sentiment'))
ggsave("densitychartggplot.png")
#Violin graph to view a relationship between string_count and piazza email and sentiment
my_data %>%
  ggplot() + 
  geom_violin(aes(x = contains_piazza, y = string_count, fill = contains_piazza)) +
  labs(title= "Comparing non-Piazza Email Lengths to Piazza Email Lengths, and Sentiment", y = "String Count", x = "Piazza Email",
       subtitle="Good sentiment emails seem to have short and similar work count (ignoring extremes). \n\nGood sentiment: {closest_state}",
       fill = "") +
  transition_states(good_sentiment_body) +
  scale_fill_discrete(labels=c('Not Piazza Email', 'Piazza Email'))
anim_save("violinanimationgg.gif")
