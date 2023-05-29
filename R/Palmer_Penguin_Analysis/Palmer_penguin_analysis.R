# Firstly, we install following packages and load a libraries

install.packages("here")
install.packages("skimr")
install.packages("janitor")
install.packages("tidyverse")
install.packages("dplyr")

library("here")
library("skimr")
library("janitor")
library("tidyverse")
library("dplyr")

# We can see a preview of our data

skim_without_charts(penguins_size)

print(penguins_size)

head(penguins_size)

# We want to exclude column Species from dataset

penguins_size %>%
  select(-species)

# We want to rename column Island as Island_new

penguins_size %>%
  rename(Island_new=island)

# In order to make sure that column names are clean and consistent we use clean_names function
# It is part of Janitor package and ensures that there's only characters, numbers, and underscores in the names.

clean_names(penguins_size)

# Arrange function allows us to sort data. Let´s sort by body mass.

penguins_size %>%
  arrange(body_mass_g)

# Now, we want to sort by body mass in descending order.

penguins2 <- penguins_size  %>%
  arrange(-body_mass_g)
view(penguins2)

# What is an average flipper length of penguins living in particular islands?

penguins_size %>% group_by(island) %>% drop_na() %>% summarize(mean_flipper_length_mm = mean(flipper_length_mm))

# What is a maximum body mass of penguins living in particular islands?

penguins_size %>% group_by(island) %>% drop_na() %>% summarize(max_body_mass_g = max(body_mass_g))

# What is an average body mass and maximum flipper length of penguins per species and islands?

penguins_size %>% group_by(species, island) %>% drop_na() %>% summarize(mean_body_mass_g = mean(body_mass_g), max_flipper_length_mm = max(flipper_length_mm))

# Let´s filter only Adelie species and create new column showing body mass in kg.

penguins2 %>% filter(species == "Adelie")

penguins2 %>% mutate(body_mass_kg=body_mass_g/1000)
print(penguins2)

# We want to create visuals so let´s install and load ggplot package.

install.packages("ggplot2")
library ("ggplot2")

# Visual 1: scatterplot showing relationship between body mass and flipper length

ggplot(data = penguins_size) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, shape = species), color = "lightblue") +
  labs(title = "Palmer penguins: Body Mass vs. Flipper Length", subtitle = "Sample of three penguin species", caption = "Data collected by Dr. Kristen Gorman") + 
  annotate("text", x=200, y=3500, label = "The Gentoos are the largest", fontface = "italic", size=3.5, angle=25)

# Visual 2: relationship between body mass and flipper length

ggplot(data = penguins_size) +
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  labs(title = "Palmer penguins: Body Mass vs. Flipper Length", subtitle = "Sample of three penguin species", caption = "Data collected by Dr. Kristen Gorman")

# Visual 3: scatterplots showing relationship between body mass and flipper length for different species

ggplot(data = penguins_size) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + facet_wrap(~species) + 
  labs(title = "Palmer penguins: Body Mass vs. Flipper Length per species", caption = "Data collected by Dr. Kristen Gorman")
