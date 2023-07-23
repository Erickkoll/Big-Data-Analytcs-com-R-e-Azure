# Solução Lista de Exercícios - Capítulo 13

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/cap13")
getwd()


# Para este exemplo, usaremos o dataset Titanic do Kaggle. 
# Este dataset é famoso e usamos parte dele nas aulas de SQL.
# Ele normalmente é usado por aqueles que estão começando em Machine Learning.

# Vamos prever uma classificação - sobreviventes e não sobreviventes

# https://www.kaggle.com/c/titanic/data


# Comecamos carregando o dataset de dados_treino
dados_tinatic <- read.csv('datasets/titanic-train.csv')
dados_teste <- read.csv('datasets/titanic-test.csv')
View(dados_treino)

# Analise exploratória de dados
# Vamos usar o pacote Amelia e suas funções para definir o volume de dados Missing
# Clique no zoom para visualizar o grafico
# Cerca de 20% dos dados sobre idade estão Missing (faltando)
install.packages("Amelia")
library(Amelia)

?missmap
missmap(dados_tinatic, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("yellow", "black"), 
        legend = FALSE)
missmap(dados_teste, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("yellow", "black"), 
        legend = FALSE)


# Visualizando os dados
library(ggplot2)
ggplot(dados_tinatic,aes(Survived)) + geom_bar()
ggplot(dados_tinatic,aes(Pclass)) + geom_bar(aes(fill = factor(Pclass)), alpha = 0.5)
ggplot(dados_tinatic,aes(Sex)) + geom_bar(aes(fill = factor(Sex)), alpha = 0.5)
ggplot(dados_tinatic,aes(Age)) + geom_histogram(fill = 'blue', bins = 20, alpha = 0.5)
ggplot(dados_tinatic,aes(SibSp)) + geom_bar(fill = 'red', alpha = 0.5)
ggplot(dados_tinatic,aes(Fare)) + geom_histogram(fill = 'green', color = 'black', alpha = 0.5)

# Limpando os dados
# Para tratar os dados missing, usaremos o recurso de imputation.
# Essa técnica visa substituir os valores missing por outros valores,
# que podem ser a média da variável ou qualquer outro valor escolhido pelo Cientista de Dados

# Por exemplo, vamos verificar as idades por classe de passageiro (baixa, média, alta):
pl <- ggplot(dados_tinatic, aes(Pclass,Age)) + geom_boxplot(aes(group = Pclass, fill = factor(Pclass), alpha = 0.4)) 
pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))

# Vimos que os passageiros mais ricos, nas classes mais altas, tendem a ser mais velhos. 
# Usaremos esta média para imputar as idades Missing
impute_age <- function(age, class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(dados_tinatic$Age, dados_tinatic$Pclass)
dados_tinatic$Age <- fixed.ages

# Visualizando o mapa de valores missing (nao existem mais dados missing)
missmap(dados_tinatic, 
        main = "Titanic Training Data - Mapa de Dados Missing", 
        col = c("yellow", "black"), 
        legend = FALSE)
View(dados_treino)


# Exercício 1 - Crie o modelo de classificação e faça as previsões
library(mlbench)
library(naivebayes)
?kmeans



dados_tinatic <- dados_tinatic[,-which(names(dados_tinatic) %in% c("Cabin","Name","Ticket","Embarked"))]
View(dados_tinatic)

str(dados_tinatic)

# Definindo a proporção de treinamento
proporcao_treino <- 0.7

# Amostragem para criar o conjunto de treinamento
indice_treino <- sample(1:nrow(dados_tinatic), proporcao_treino * nrow(dados_tinatic))


dados_treino <- dados_tinatic[indice_treino, ]
dados_teste <- dados_tinatic[-indice_treino, ]

dados_treino$Survived <- as.factor(dados_treino$Survived)

modelo <- naive_bayes(Survived ~ ., data = dados_treino)
previsoes <- predict(modelo, newdata = dados_teste)
output <- table(previsoes)
barplot(output, main = "Distribuição das Previsões", xlab = "Previsão", ylab = "Frequência")
