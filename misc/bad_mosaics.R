library(ggplot2)
data(diabetes, package = 'medicaldata')
colnames(diabetes)
colnames(diabetes)[2] <- "glucose_mg_dl"
colnames(diabetes)[3] <- "dbp_mm_hg"
diabetes

ggplot(data = diabetes, aes(x = age, y = ..density..), na.rm = TRUE) + geom_density(aes(fill = diabetes_5y), position="stack")

ggplot(data = diabetes, aes(x = age, y = ..density..), na.rm = TRUE) + geom_density(aes(fill = diabetes_5y), position="stack")

data(cytomegalovirus, package = 'medicaldata')

cytomegalovirus %>%
  filter(cmv == 1) %>%
  ggplot(aes(x=age, fill=diagnosis)) +
  geom_density(position="fill") +
  scale_y_continuous(name="%", labels=scales::percent)

library(ggmosaic)

cytomegalovirus %>%
  mutate(chemo_prior = factor(prior.chemo),
         cmv_factor = factor(cmv)) %>%
ggplot() +
  geom_mosaic(aes(x = product(diagnosis, chemo_prior), fill=cmv_factor)) +
  theme_mosaic()

ggplot(data = fly) +
  geom_mosaic(aes(x = product(rude_to_recline), fill=do_you_recline)) +
  theme_mosaic()

