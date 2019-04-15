# Tidyverse tutorial
# Created by Matthew T. Pileggi
# Presented 4/15/19

# Installs tidyverse packages
# install.packages("tidyverse")

# Loads & attaches core packages

library(tidyverse)

# readr

fly_data <- read_csv("data/flies.csv")

fly_data

# tibble

fly_data

str(fly_data)

# dplr

select(fly_data, species, sugar, eggs_laid)

select(fly_data, -id)

# magrittr

fly_data %>% 
  group_by(sugar, species) %>% 
  summarize(avg_eggs_laid = mean(eggs_laid))

# ggplot2

fly_data %>% 
  mutate(sugar = fct_reorder(sugar, eggs_laid)) %>% 
  ggplot(aes(x = species, y = eggs_laid, fill = sugar)) +
  geom_bar(position = "dodge", stat = "identity")

fly_data %>% 
  group_by(species, sugar) %>%
  summarise(mean.eggs = mean(eggs_laid),
            sd.eggs = sd(eggs_laid),
            n.eggs = n()) %>%
  mutate(se.eggs = sd.eggs / sqrt(n.eggs)) %>%
  mutate(sugar = fct_reorder(sugar, mean.eggs)) %>% 
  ggplot(aes(sugar, mean.eggs, group = species, color = species)) +
  geom_errorbar(aes(ymin= mean.eggs-se.eggs, ymax = mean.eggs+se.eggs, width = .1),
                position = position_dodge(0.1)) +
  geom_line(position = position_dodge(0.1)) +
  geom_point(position = position_dodge(0.1))