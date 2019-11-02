#' zona de notas
#' 

# practica 02 -------------------------------------------------------------

#importar base en formato DTA
espir <- read_dta("data-raw/espirometria.dta") %>% as_factor()

#generar resumen descriptivo
espir %>% skim()

#grafica distribución
espir %>% 
  ggplot(aes(_____)) +
  geom_histogram()

#realizar pruebas de hipótesis
#experimenta y describe qué cambios genera cada uno de los argumentos?
compareGroups(formula = _____ ~ edad + _____ + _____ + sexo,
              data = espir, 
              
              byrow=T,
              
              method=c(vef=2)
              
              ) %>% 
  
  createTable(show.all = T) %>% 
  
  export2xls("table/tab1.xls")


# correlaciones -----------------------------------------------------------

espir %>% 
  select(edad,vef,talla) %>% 
  correlate() %>% 
  stretch()

espir %>% 
  select(edad,vef,talla) %>% 
  as.matrix() %>% 
  Hmisc::rcorr() %>% 
  broom::tidy()


# modelos lineales --------------------------------------------------------

#regresar luego de finalizado el capítulo de regresiones
t.test(vef ~ fumar, data = espir,var.equal=TRUE) %>% 
  tidy()
lm(vef ~ 1+ fumar, data = espir) %>% tidy()
lm(vef ~ 1+ fumar, data = espir) %>% confint_tidy()
