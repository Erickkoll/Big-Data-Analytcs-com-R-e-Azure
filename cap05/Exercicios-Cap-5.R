# Solução Lista de Exercícios - Capítulo 5 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/cap05")
getwd()


# Exercicio 1 - Encontre e faça a correção do erro na instrução abaixo:

View(read.table("mtcars2.txt", header=TRUE,sep = "|", stringsAsFactors = FALSE))

read.table("mtcars2.txt", header=TRUE,sep = "|", stringsAsFactors = FALSE)

write.table(mtcars,"mtcars3.txt", sep = "|", col.names = NA, qmethod = "double")

df_reda_mtcars <- read.table("mtcars3.txt", header=TRUE,sep = "|", stringsAsFactors = FALSE)

View(df_reda_mtcars)

# Exercicio 2 - Encontre e faça a correção do erro na instrução abaixo:
install.packages("readr")
library(readr)
r_iris <- read.table("iris.csv")
View(r_iris)

df_iris <- read_csv("iris.csv", col_types = cols(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))
View(df_iris)

# Exercício 3 - Abaixo você encontra dois histogramas criados separadamente.
# Mas isso dificulta a comparação das distribuições. Crie um novo plot que faça a união 
# de ambos histogramas em apenas uma área de plotagem.

# Dados aleatórios

install.packages("gridExtra")
library(ggplot2)
library(gridExtra)

dataset1 <- data.frame(x= rnorm(4000 , 100 , 30),y=rnorm(4000 , 100 , 30))     
dataset2 <- data.frame(x= rnorm(4000 , 200 , 30),y=rnorm(4000 , 200 , 30)) 

plot1 <- ggplot(dataset1, aes(x = x, y = y)) + geom_point() + xlim(-50,350) + ylim(-50,350)
plot2 <- ggplot(dataset2, aes(x = x, y = y)) + geom_point() + xlim(-50,350) + ylim(-50,350)

grid.arrange(plot1, plot2, ncol=2)

# Histogramas
par(mfrow=c(1,2))

# remova os valores ausentes da coluna "x" antes de plotar o histograma
dataset1$x <- dataset1$x[!is.na(dataset1$x)]
dataset2$x <- dataset2$x[!is.na(dataset2$x)]

histogram1 <- ggplot(dataset1, aes(x = x)) + geom_histogram(bins = 30 ,col=rgb(1,0,0,0.5), na.rm = TRUE) + xlim(0,300) + xlab("Altura") + ylab("Peso") + ggtitle("")
histogram2 <- ggplot(dataset1, aes(x = x)) + geom_histogram(bins = 30 ,col=rgb(0,0,1,0.5), na.rm = TRUE) + xlim(0,300) + xlab("Altura") + ylab("Peso") + ggtitle("")

grid.arrange(histogram1,histogram2, ncol=2)

# criar dados de exemplo
set.seed(123)
x1 <- rnorm(4000 , 100 , 30)
x2 <- rnorm(4000 , 200 , 30)

# plotar histogramas lado a lado
par(mfrow = c(1, 2))
hist(x1,breaks = 30 ,col=rgb(1,0,0,0.5), xlim=c(0,300), xlab ="Altura", ylab = "Peso", main = "Histograma 1")
hist(x2,breaks = 30 ,col=rgb(0,0,1,0.5), xlim=c(0,300), xlab ="Altura", ylab = "Peso", main = "Histograma 2")

# Exercício 4 - Encontre e corrija o erro no gráfico abaixo
install.packages("plotly")
library(plotly)
head(iris)
View(iris)

plot_ly(iris, 
        x = ~Petal.Length, 
        y = ~Petal.Width,  
        type="scatter", 
        mode = "markers" , 
        color = iris$Species , marker=list(size=20 , opacity=0.5))


# Exercício 5 - Em anexo você encontra o arquivo exercicio5.png. Crie o gráfico que resulta nesta imagem.

library(plotly)

# Definindo a função de superfície
surface <- function(x, y) {
  z <- 185 - 3 * sqrt((x - 30)^2 + (y - 60)^2)
  z[x == 60 | x == 0 | y == 60] <- 0
  return(z)
}

# Gerando os dados da superfície
x <- seq(0, 60, length.out = 100)
y <- seq(0, 60, length.out = 100)
z <- outer(x, y, surface)

# Gerando as cores com o gradiente desejado
colfunc <- colorRampPalette(c("blue", "green", "yellow"))
colors <- colfunc(100)

# Plotando o gráfico 3D
persp(x, y, z, col = colors, theta = -30, phi = 30,
      xlim = c(0, 60), ylim = c(0, 60), zlim = c(0, 180),
      xlab = "X", ylab = "Y", zlab = "Z")


# Exercício 6 - Carregue o arquivo input.json anexo a este script e imprima o conteúdo no console
# Dica: Use o pacote rjson

# Instalar e carregar o pacote rjson, se necessário

install.packages("rjson")
library(rjson)

# Ler o conteúdo do arquivo input.json
json_file <- file("input.json", "r")
json_content <- readLines(json_file)
close(json_file)

# Converter o conteúdo para um objeto JSON
json_parsed <- fromJSON(paste(json_content, collapse = ""))

# Imprimir o conteúdo no console
print(json_parsed)
View(json_parsed)



# Exercício 7 - Converta o objeto criado ao carregar o arquivo json do exercício anterior 
# em um dataframe e imprima o conteúdo no console.
df_json <- data.frame(json_parsed)
print(df_json)
View(df_json)

# Exercício 8 - Carregue o arquivo input.xml anexo a este script.
# Dica: Use o pacote XML
install.packages("XML")
library(XML)

# Ler o arquivo input.xml
xml_file <- xmlParse("input.xml")

# Exercício 9 - Converta o objeto criado no exercício anterior em um dataframe

# Converter o objeto XML em dataframe
df_xml <- xmlToDataFrame(xml_file)

# Imprimir o conteúdo no console
print(df_xml)


# Exercício 10 - Carregue o arquivo input.csv em anexo e então responda às seguintes perguntas:

dados <- read.csv("input.csv")
View(dados)

# Pergunta 1 - Quantas linhas e quantas colunas tem o objeto resultante em R?
nrow(dados)
ncol(dados)
# Pergunta 2 - Qual o maior salário?
max_salary <- max(dados$salary)
print(max_salary)
# Pergunta 3 - Imprima no console o registro da pessoa com o maior salário.
max_row_salary <- which.max(dados$salary)
print(dados[max_row_salary,"name"])

# Pergunta 4 - Imprima no console todas as pessoas que trabalham no departamento de IT.
it_workers <- dados[dados$dept == "IT", ]
print(it_workers)

salary_workers <- dados[dados$salary > 700, ]
print(salary_workers$salary)
# Pergunta 5 - Imprima no console as pessoas do departamento de IT com salário superior a 600. 
it_works_salary_600 <- dados[dados$dept == "IT" & dados$salary > 600, ]
print(it_works_salary_600$name)

