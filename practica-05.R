#' zona de notas
#' 

# practica 05 -------------------------------------------------------------

# importar datos ----------------------------------------------------------

cleaned_data <- read_rds("data-raw/microarraydata.rds")

plot_expression_data <- function(expression_data) {
  ggplot(expression_data, aes(rate, expression, color = nutrient)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(~name + systematic_name, scales = "free_y")
}

# visualization -----------------------------------------------------------

cleaned_data %>%
  filter(BP == "leucine biosynthesis") %>%
  plot_expression_data()

cleaned_data %>%
  filter(BP == "cell wall organization and biogenesis") %>%
  plot_expression_data()

# single regression -------------------------------------------------------

LEU1_leucine <- cleaned_data %>%
  filter(name == "LEU1", nutrient == "Leucine")

ggplot(LEU1_leucine, aes(rate, expression)) +
  geom_point()

mod <- lm(expression ~ rate, LEU1_leucine)
summary(mod)

tidy(mod)

# to all combination of gene and nutrient ---------------------------------

cleaned_data %>% count(nutrient)

#reducimos la base para reducir el tiempo de ejecución
linear_models <- cleaned_data %>%
  
  filter(nutrient=="Ammonia") %>% 
  
  group_by(name, systematic_name, nutrient) %>%
  nest() %>% 
  mutate(model = map(data, ~ lm(expression ~ rate, data = .x)),
         tidym = map(model,tidy))

# conserva pendientes -----------------------------------------------------

slope_terms <- linear_models %>% 
  unnest(cols = c(tidym)) %>% 
  ungroup() %>% 
  filter(term=="rate" & !is.na(p.value)) 

slope_terms %>% 
  ggplot(aes(p.value)) +
  geom_histogram(binwidth = .05) +
  facet_wrap(~nutrient)

# corrige valoes p --------------------------------------------------------

slope_terms_adj <- slope_terms %>% 
  mutate(q.value = qvalue(p.value)$qvalues,
         q.value_pass=if_else(q.value < .01,"TRUE","FALSE")) 

slope_terms_adj %>% 
  ggplot(aes(p.value,fill=q.value_pass)) +
  geom_histogram(binwidth = .05) +
  facet_wrap(~nutrient)

# genera lista de valores p -----------------------------------------------

slope_terms_adj %>% 
  filter(q.value_pass=="TRUE") %>% 
  arrange(q.value)

# explora paquetes alternativos -------------------------------------------

library(qvalue)

#datos microarray
qmicro <- qvalue(p = slope_terms$p.value)
summary(qmicro)
hist(qmicro)
plot(qmicro)