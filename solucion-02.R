#' zona de notas
#' 

library(tidyverse)
library(haven)
library(skimr)
library(compareGroups)
library(corrr)
library(Hmisc)

# practica 02 -------------------------------------------------------------

#importar base en formato DTA
espir <- read_dta("data-raw/espirometria.dta") %>% as_factor()

#generar resumen descriptivo
espir %>% skim_to_wide() %>% writexl::write_xlsx(path = "table/skimtable.xlsx")

# variables categóricas ---------------------------------------------------

espir %>% 
  tabyl(sexo) %>%  #<<
  adorn_totals("row") %>% 
  adorn_pct_formatting()

espir %>% 
  tabyl(sexo,fumar) %>%  #<<
  adorn_totals(c("col")) %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting() %>% 
  adorn_ns(position = "front") %>% 
  adorn_title()

# comparación de proporciones ---------------------------------------------

espir %>% 
  tabyl(sexo,fumar) %>% 
  chisq.test() %>%  #<<
  tidy()

# variables numericas -----------------------------------------------------

#grafica distribución
espir %>% 
  ggplot(aes(x = edad)) +
  geom_histogram()

espir %>% 
  ggplot(aes(x=talla,y=vef)) + #<<
  geom_point() +
  geom_smooth(method = "lm")

# correlaciones -----------------------------------------------------------

espir %>% 
  select(edad,vef,talla) %>% 
  correlate() %>% 
  stretch() %>% 
  arrange(desc(r))

espir %>% 
  select(edad,vef,talla) %>% 
  as.matrix() %>% 
  Hmisc::rcorr() %>% 
  broom::tidy()

# variables numericas y  categóricas --------------------------------------

espir %>% 
  ggplot(aes(x=fumar,y=vef)) +
  geom_point(
    aes(color=fumar), #<<
    position = "jitter") + #<<
  geom_boxplot(alpha=0) #<<

espir %>% 
  ggplot(aes(x=fumar,y=vef)) +
  geom_violin(aes(color=fumar)) #<<

espir %>%
  select(fumar,vef) %>%
  group_by(fumar) %>%  #<<
  skim()

# comparar medias entre dos grupos ----------------------------------------

t.test(vef ~ fumar, data = espir, var.equal=FALSE) %>%
  tidy()

# tabla resumen -----------------------------------------------------------

#realizar pruebas de hipótesis
#experimenta y describe qué cambios genera cada uno de los argumentos?
compareGroups(formula = fumar ~ edad + vef + sexo,
              data = espir, 
              byrow=T,method=c(vef=2)
              ) %>% 
  createTable(show.all = F) %>% 
  export2xls("table/tab1.xls")

# modelos lineales --------------------------------------------------------
# relación entre modelos lineales y pruebas de hipotesis
#regresar luego de finalizado el capítulo de regresiones

# Lindeløv J. (2019) 
# Common statistical tests are linear models (or: how to teach stats) 
# [Github personal webpage](https://lindeloev.github.io/tests-as-linear/)

#regresar luego de finalizado el capítulo de regresiones
t.test(vef ~ fumar, data = espir,var.equal=TRUE) %>% 
  tidy()
lm(vef ~ 1+ fumar, data = espir) %>% tidy()
lm(vef ~ 1+ fumar, data = espir) %>% confint_tidy()
