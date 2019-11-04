#' zona de notas
#' 

# practica 04 -------------------------------------------------------------

library(tidyverse)
library(haven)
library(broom)

aidsdb <- read_dta("data-raw/aidsdb.dta") %>% as_factor() %>% 
  mutate_if(.predicate = is.factor,.funs = fct_relevel,... = "No")

# resolver e interpretar

# ¿Qué otros marcadores están asociados con el desarrollo de SIDA? --------

# recordar: y ~ x
wm1 <- glm(aids ~ ccr2, data = aidsdb, family = binomial(link = "logit"))

wm1 %>% glance()
wm1 %>% tidy()
wm1 %>% confint_tidy()
wm1 %>% augment()

wm1 %>% avallecam::epi_tidymodel_or()

# Intenta ajustar por otras covariables como edad, raza o sexo ------------

# recordar: y ~ x
wm1 <- glm(aids ~ ccr5 + race, data = aidsdb, family = binomial(link = "logit"))

wm1 %>% glance()
wm1 %>% tidy()
wm1 %>% confint_tidy()
wm1 %>% augment()

wm1 %>% avallecam::epi_tidymodel_or()