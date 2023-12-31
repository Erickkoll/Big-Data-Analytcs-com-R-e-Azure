# Lista de Exercícios - Capítulo 2

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/FCD/BigDataRAzure/Cap02")
getwd()

# Exercício 1 - Crie um vetor com 30 números inteiros

# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida com números inteiros

# Exercício 3 - Crie uma lista unindo o vetor e matriz criados anteriormente

# Exercício 4 - Usando a função read.table() leia o arquivo do link abaixo para uma dataframe
# http://data.princeton.edu/wws509/datasets/effort.dat

# Exercício 5 - Transforme o dataframe anterior, em um dataframe nomeado com os seguintes labels:
# c("config", "esfc", "chang")

# Exercício 6 - Imprima na tela o dataframe iris, verifique quantas dimensões existem no dataframe iris e imprima um resumo do dataset

# Exercício 7 - Crie um plot simples usando as duas primeiras colunas do dataframe iris

# Exercício 8 - Usando a função subset, crie um novo dataframe com o conjunto de dados do dataframe iris em que Sepal.Length > 7
# Dica: consulte o help para aprender como usar a função subset()

# Exercícios 9 (Desafio) - Crie um dataframe que seja cópia do dataframe iris e usando a função slice(), divida o dataframe em um subset de 15 linhas
# Dica 1: Você vai ter que instalar e carregar o pacote dplyr
# Dica 2: Consulte o help para aprender como usar a função slice()

# Exercícios 10 - Use a função filter no seu novo dataframe criado no item anterior e retorne apenas valores em que Sepal.Length > 6
# Dica: Use o RSiteSearch para aprender como usar a função filter

# Exercício 1 
v1 = seq(1:30)
v1
# Exercício 2
m1 = matrix(seq(1:16),nr=4)
m1
# Exercício 3
s1 = m1 + v1
s1
v2 = seq(1:4)
s2 = m1+v2
s2
# Exercício 4
# Baixando o arquivo
file_url <- "http://data.princeton.edu/wws509/datasets/effort.dat"
download.file(file_url, destfile = "effort.dat")

# Lendo o arquivo para um dataframe
df <- read.table("effort.dat", header = T)

# Exercício 6
library(datasets)
data(iris)
head(iris)

# Exercício 7

library(ggplot2)
data(iris)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

# Exercício 7

iris_subset <- subset(iris, Sepal.Length < 7)
ggplot(iris_subset, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

# Exercício 8

install.packages("dplyr")
library(dplyr)
iris_slice <- slice(iris,1:15)
iris_slice <- filter(iris_slice, Sepal.Length < 5)
ggplot(iris_slice, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

lista1 <- list(a=(1:20), b=(45:77))
sapply(lista1, sum)
