install.packages("here")
install.packages("skimr")
install.packages("janitor")

library("here")
library("skimr")
library("janitor")

skim_without_charts(penguins_size)
install.packages("dplyr")
library("dplyr")

print(penguins_size)
head(penguins_size)

install.packages("tidyverse")
library("tidyverse")

penguins_size %>%
  select(-species)

penguins_size %>%
  rename(Island_new=island)

clean_names(penguins_size)

penguins_size %>%
  arrange(body_mass_g)

penguins2 <- penguins_size  %>%
  arrange(-body_mass_g)
view(penguins2)

penguins_size %>% group_by(island) %>% drop_na() %>% summarize(mean_flipper_length_mm = mean(flipper_length_mm))

penguins_size %>% group_by(island) %>% drop_na() %>% summarize(max_body_mass_g = max(body_mass_g))

penguins_size %>% group_by(species, island) %>% drop_na() %>% summarize(mean_body_mass_g = mean(body_mass_g), max_flipper_length_mm = max(flipper_length_mm))

penguins2 %>% filter(species == "Adelie")

penguins2 %>% mutate(body_mass_kg=body_mass_g/1000)
print(penguins2)

install.packages("ggplot2")
library ("ggplot2")

ggplot(data = penguins_size) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, shape = species), color = "lightblue") +
  labs(title = "Palmer penguins: Body Mass vs. Flipper Length", subtitle = "Sample of three penguin species", caption = "Data collected by Dr. Kristen Gorman") + 
  annotate("text", x=200, y=3500, label = "The Gentoos are the largest", fontface = "italic", size=3.5, angle=25)

ggplot(data = penguins_size) +
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins_size) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_wrap(~species)

ggplot(data = penguins_size) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g)) + facet_grid(sex~species)
