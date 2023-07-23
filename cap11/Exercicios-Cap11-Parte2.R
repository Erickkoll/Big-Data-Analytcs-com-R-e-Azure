# Lista de Exercícios Parte 2 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/Cap11")
getwd()

# Regressão Linear
# Definição do Problema: Prever as notas dos alunos com base em diversas métricas
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Dataset com dados de estudantes
# Vamos prever a nota final (grade) dos alunos

# Carregando o dataset
df <- read.csv2('estudantes.csv')


# Explorando os dados
head(df)
View(df)
summary(df)
dim(df)
str(df)
any(is.na(df))

na.omit(df)
dim(df)

# install.packages("ggplot2")
# install.packages("ggthemes")
# install.packages("dplyr")
install.packages("rpart")
install.packages("caTools")
library(ggplot2)
library(ggthemes)
library(dplyr)
library(rpart)
library(caTools)


df <- df %>%
  mutate(across(school:absences, as.character))
#  mutate(G = rowMeans(select(., G1:G3), na.rm = TRUE)) %>%
#  select(-G1,-G2,-G3)

set.seed(101)
amostra <- sample.split(df$age, SplitRatio = 0.70)
treino = subset(df, amostra == TRUE)
teste = subset(df, amostra == FALSE)


View(df)

str(df)
modelo <- lm(G3 ~ ., data = treino)
modelo
summary(modelo)
df <- df %>%
  select(G,sex,studytime, failures,schoolsup,famsup,goout,famsize,reason,freetime,health,absences)

View(df)

modelo_rf <- rpart(G ~ ., data = df)
summary(modelo_rf)
