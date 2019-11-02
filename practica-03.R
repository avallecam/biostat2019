#' zona de notas
#' 

# practica 03 -------------------------------------------------------------

# ajustar una recta -------------------------------------------------------

espir %>% 
  ggplot(aes(edad,talla)) +
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