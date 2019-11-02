#' zona de notas
#' 

# practica 01 -------------------------------------------------------------

hola
"hola"

a <- 5
(a <- 5)

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
plot(women)
hist(women)

a <- 1
b <- "uno"
c <- TRUE

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
heights %>% mean()

library(tidyverse) # pipe podrá ser usado al ejecutar esta línea
heights %>% mean()
heights %>% mean() %>% log10()
heights %>% mean() %>% log10() %>% class()

# funciones y argumentos ---------------------------------------------------

heights <- c(NA, 153.5, 152.5, 162.0, 153.9, 156.2, 152.6, 151.9, 154.3)

heights

mean(heights)
sd(heights)

mean(heights,na.rm = T)
sd(heights,na.rm = T)

summary(heights)

bw <- "blue"
hist(heights)
hist(heights,col = bw)

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

