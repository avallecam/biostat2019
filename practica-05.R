#' zona de notas
#' 

# practica 05 -------------------------------------------------------------

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(broom)
library(qvalue)
library(purrr)

# sección para generar la base y guardarla --------------------------------
# fuente
# Robinson D. (2014). 
# Modeling gene expression with broom: a case study in tidy analysis. 
# [Variance explained blog](http://varianceexplained.org/r/tidy-genomics-broom/)

url <- "http://varianceexplained.org/files/Brauer2008_DataSet1.tds"

nutrient_names <- c(G = "Glucose", L = "Leucine", P = "Phosphate",
                    S = "Sulfate", N = "Ammonia", U = "Uracil")

cleaned_data <- read_delim(url, delim = "\t") %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  mutate_each(funs(trimws), name:systematic_name) %>%
  select(-number, -GID, -YORF, -GWEIGHT) %>%
  gather(sample, expression, G0.05:U0.3) %>%
  separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE) %>%
  mutate(nutrient = plyr::revalue(nutrient, nutrient_names)) %>%
  filter(!is.na(expression), systematic_name != "")

write_rds(cleaned_data,"data/microarraydata.rds")

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

cleaned_data %>%
  #elegimos 01 gen y 01 nutriente
  filter(name == "LEU1", nutrient == "Leucine") %>% 
  #graficamos la relación Y: expresión ~ X: rate
  ggplot(aes(rate, expression)) +
  #empleamos la geometría punto
  geom_point()

cleaned_data %>%
  #elegimos 01 gen y 01 nutriente
  filter(name == "LEU1", nutrient == "Leucine") %>% 
  #graficamos la relación Y: expresión ~ X: rate
  ggplot(aes(rate, expression)) +
  #empleamos la geometría punto
  geom_point() + geom_smooth(method = "lm")

  cleaned_data %>%
  #elegimos 01 gen y 01 nutriente
  filter(name == "LEU1", nutrient == "Leucine") %>% 
  #ajustamos una regresión lineal
  #dado que data no es el primer argumento
  #necesitamos especificarlo en data con "."
  lm(expression ~ rate, data = .) %>% 
  #visualizamos tabla con estimados
  tidy()


# to all combination of gene and nutrient ---------------------------------

cleaned_data %>% count(nutrient)

linear_models <- cleaned_data %>%
  filter(nutrient=="Ammonia") %>% #filtramos por nutriente #<<
  group_by(name, systematic_name, nutrient) %>% #agrupamos por gen
  nest() %>% #anidamos los datos en una columna lista de df #<<
  # ajustamos un modelo lineal a cada fila -ver paquete purrr::map-
  mutate(model = map(data, ~ lm(expression ~ rate, data = .x)), #<<
         tidym = map(model,tidy)) #<<


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