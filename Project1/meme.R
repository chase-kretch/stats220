library(magick) ### loads magick package

happy_cat <- image_read("happy_cat.jpg") %>%
  image_scale(500) %>% ### assigns happy cat and scales to correct size
    image_border("black","0x3")
sad_cat <- image_read("sad_cat.jpg") %>%
  image_scale(500) %>% ### assigns sad cat and scales to correct size
    image_border("black","0x3")

top_txt <- image_blank(width = 500, ### assigns top text of meme, using a blank image
                       height = 500, ### and matches height and width to our chosen images
                       color = "#FFFFFF") %>%
    image_annotate(text = "Due Tomorrow",
                  size = 60,
                  font = "Impact",
                  gravity = "center") %>%
    image_border("black","3x3")

bottom_txt <- image_blank(width = 500, ### assigns bottom text of meme
                          height = 500,
                          color = "#FFFFFF") %>%
  image_annotate(text = "Do Tomorrow",
                 size = 60,
                 font = "Impact",
                 gravity = "center") %>%
  image_border("black","3x3")


top_row <- c(sad_cat, top_txt) %>% ### creates the top row vector using our top image (sad_cat)
  image_append() ### and top text

bottom_row <- c(happy_cat, bottom_txt) %>% ### does the same thing but for the bottom
  image_append()


meme <- c(top_row, bottom_row) %>% ### puts the two vectors to make a final vector
  image_append(stack = TRUE)
image_write(meme, "cat_meme.png")
meme
                










