#' zona de notas
#' 

# practica 03 -------------------------------------------------------------

library(tidyverse)
library(haven)
library(broom)
espir <- read_dta("data-raw/espirometria.dta") %>% as_factor()

# repaso -------------------------------------------------------------

library(janitor)

#variables categóricas
espir %>% 
  tabyl(sexo,fumar)

#variables numéricas
espir %>% 
  ggplot(aes(x = edad)) +
  geom_histogram()

# practica 03 -------------------------------------------------------------

# ajustar una recta -------------------------------------------------------

#scatterplot de dos variables numéricas
espir %>% 
  ggplot(aes(x = talla,y = vef)) +
  geom_point() +
  geom_smooth()

# identificar coeficientes y R^2^ -----------------------------------------

# recordar: y ~ x
wm1 <- lm(vef ~ talla, data = espir)
wm1 %>% glance()
wm1 %>% tidy()
wm1 %>% confint_tidy()

# evaluar supuestos: normalidad y homoscedasticidad -----------------------

#identificar los nuevos elementos otorgados por la función augment
# valores predichos en fitted
# valores de residuales por cada par de observaciones en .std.resid
wm1 %>% augment()

wm1 %>% augment() %>% 
  ggplot(aes(.std.resid)) + geom_histogram()

wm1 %>% augment() %>% 
  ggplot(aes(.fitted,.std.resid)) + 
  geom_point() +
  geom_smooth()