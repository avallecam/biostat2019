#' zona de notas
#' 

# practica 01 -------------------------------------------------------------

hola #error
"hola"

a <- 5 #no imprime resultado
(a <- 5) #sí imprime resultado

# operaciones aritméticas -------------------------------------------------

2
2+2
4-2
2*5
10/2
((2*4)+(7^3/(1/ (5^2)))-755)^2

# asignar o crear objetos -------------------------------------------------

x <- 2
x+2
x-1
x*3
x/2
x^2 +2*x + 4

# funciones --------------------------------------------------

1:10
seq(1,10)
rep(1,5)

a <- 1
b <- "uno"
c <- TRUE

# class te dice qué tipo de objeto es 
class(a)
class(b)
class(c)

# vectores ----------------------------------------------------------------

heights <- c(147.2, 153.5, 152.5, 162.0, 153.9, 156.2, 152.6, 151.9, 154.3)
mean(heights)
sd(heights)
summary(heights)

# pipe --------------------------------------------------------------------

# este símbolo "%>%" es llamado pipe 
# usa (Ctrl + Shit + M) para crearlo
heights
mean(heights)
heights %>% mean() #error si no tienes invocado el paquete tidyverse

library(tidyverse) # pipe podrá ser usado al ejecutar esta línea
heights %>% mean()
heights %>% mean() %>% log10()
heights %>% mean() %>% log10() %>% class()
class(heights)

# funciones y argumentos ---------------------------------------------------

alturas <- c(NA, 153.5, 152.5, 162.0, 153.9, 156.2, 152.6, 151.9, 154.3)

alturas

mean(alturas) #error
sd(alturas) #error

mean(alturas,na.rm = TRUE)
sd(alturas,na.rm = T)

summary(alturas)

# subconjuntos ------------------------------------------------------------

y <- LETTERS[1:10]
y
y[1]
y[5]
y[3:7]
y[c(1,3,5,6)]
y[3] <- "hola"
y

z <- c("hola","mi","nombre","es","_____")

# gráficos básicos -------------------------------------------------------

bw <- "blue"
hist(heights)
hist(heights,col = bw)

# dataframes --------------------------------------------------------------

women #dataframe que posee más de un vector
women$height #accedes al vector de altura

plot(women) #genera scatterplot automático
hist(women$height) #genera un histogram de un vector específico
