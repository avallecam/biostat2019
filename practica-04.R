#' zona de notas
#' 

# practica 04 -------------------------------------------------------------


# ¿Qué otros marcadores están asociados con el desarrollo de SIDA? --------

# recordar: y ~ x
wm1 <- glm(_____ ~ _____, data = _____, family = _____(link = "_____"))

wm1 %>% g_____
wm1 %>% t_____
wm1 %>% c_____
wm1 %>% a_____

wm1 %>% avallecam::epi_tidymodel_or()

# Intenta ajustar por otras covariables como edad, raza o sexo ------------

# recordar: y ~ x
wm1 <- glm(_____ ~ _____ + _____, data = _____, family = _____(link = "_____"))

wm1 %>% g_____
wm1 %>% t_____
wm1 %>% c_____
wm1 %>% a_____

wm1 %>% avallecam::epi_tidymodel_or()