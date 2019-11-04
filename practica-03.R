#' zona de notas
#' 

library(tidyverse)
library(haven)
library(broom)
espir <- read_dta("data-raw/espirometria.dta") %>% as_factor()

# practica 03 -------------------------------------------------------------

# ajustar una recta -------------------------------------------------------

espir %>% 
  ggplot(aes(talla,vef)) +
  geom____()

# identificar coeficientes y R^2^ -----------------------------------------

# recordar: y ~ x
wm1 <- lm(_____ ~ _____, data = _____)
wm1 %>% g_____
wm1 %>% t_____
wm1 %>% c_____

# evaluar supuestos: normalidad y homoscedasticidad -----------------------

wm1 %>% augment() %>% 
  ggplot() + _____

wm1 %>% augment() %>% 
  ggplot(aes(.fitted,.std.resid)) + __________