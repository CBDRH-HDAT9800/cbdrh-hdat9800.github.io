library(tidyverse)
library(readr)

hdat9800 <- read_csv(file="~/HDAT9800-2022-T2-material/HDAT9800_T2_2022_participants.csv")
hdat9500 <- read_csv(file="~/HDAT9800-2022-T2-material/HDAT9500_T2_2022_participants.csv")

hdat9800 <- hdat9800 %>%
              mutate(hdat9800 = TRUE,
                     zId = Username)

hdat9500 <- hdat9500 %>%
              mutate(hdat9500 = TRUE)

combined <- hdat9800 %>%
              full_join(hdat9500,by = c("zId"="zId"))

overlap <- combined %>%
            filter(hdat9800 & hdat9500)


