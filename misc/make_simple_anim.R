library(tidyverse)
library(gganimate)

# make a randomly increasing line
xvals <- seq(20, 106, by= 85.1/994)
sigma2 = (106 - abs(xvals - 43))^2.2
eps    = rnorm(length(xvals),mean=0,sd=sqrt(sigma2 - 1500)/10)
yvals <- (xvals * 45/85.1) + eps
line_map <- tibble(frame=0,
                   xval = xvals,
                   yval = yvals)

# read the message map
msg_map <- read_csv(here::here("msg_map.csv")) %>%
  mutate(xval = xpos + xoff, yval = ypos + yoff) %>%
  arrange(frame, xval, yval)

msg_map <- bind_rows(line_map, msg_map)

# dot count
dot_count <-  msg_map %>% group_by(frame) %>%
  summarise(count = n())

# give each dot a unique identity
msg_map$id <- dot_count$count %>%
  map(function(x){1:x}) %>% reduce(c)

# create the base plot
base_pic <- msg_map %>%
  ggplot(aes(
    x = xval,
    y = yval)) +
  geom_point(
    aes(colour = factor(id), size=10),
    show.legend = FALSE) +
  coord_equal() + labs(x="Baseline mean arterial pressure (mm Hg)", y="Vasopressor dose (mg)")  +
  theme(axis.text=element_text(size=28),
        axis.title=element_text(size=32))
# + scale_y_continuous(limits = c(0, 22))


  # construct animation
  pic <- base_pic +

    transition_states(states = frame,
                      transition_length = .7,
                      state_length = 1)  +
    ease_aes('quadratic-in') + shadow_wake(wake_length = .1)

  # save animation
  pic %>% animate(detail = 5, duration = 15,
                  nframes = 500, fps = 20, width = 1600, height=1200)

anim_save(here::here("misc/hdat9800.gif"))



