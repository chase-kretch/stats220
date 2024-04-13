library(magick)

img1 <- image_read("frame1.jpg") %>%
  image_annotate(text = "me tryna stay awake in my 9ams", size = 60, 
                 gravity = "south", color = "white") %>% 
  image_scale(500) ### scales all the images to the same size

img2 <- image_read("frame2.jpg") %>%
  image_annotate(text = "me tryna stay awake in my 9ams", size = 44.5, ### some different images have different aspect ratios
                 gravity = "south", color = "white") %>% ### so i tried my best to get the text the same
  image_scale(500)

img3 <- image_read("frame3.jpg") %>%
  image_annotate(text = "me tryna stay awake in my 9ams", size = 33, 
                 gravity = "south", color = "white") %>%
  image_scale(500)
img4 <- image_read("frame4.jpg") %>%
  image_annotate(text = "me tryna stay awake in my 9ams", size = 60, 
                 gravity = "south", color = "white") %>%
  image_scale(500)


frames = c(img1, img2, img3, img4) ### puts all my images together to create the frames

my_gif <- image_animate(frames, fps = 1) ### animates my frame vector to create the gif at 1fps
image_write(my_gif, "my_gif.gif") ### saves my gif to my folder
my_gif

