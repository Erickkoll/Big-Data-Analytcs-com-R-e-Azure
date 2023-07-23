# Solução Lista de Exercícios - Capítulo 12 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/cap12")
getwd()

# Existem diversos pacotes para arvores de recisao em R. Usaremos aqui o rpart.
install.packages('rpart')
library(rpart)

# Vamos utilizar um dataset que é disponibilizado junto com o pacote rpart
str(kyphosis)
dim(kyphosis)
head(kyphosis)

# Exercício 1 - Depois de explorar o dataset, crie um modelo de árvore de decisão
#kyphosis$Start <- as.character(kyphosis$Start)
kyphosis$Start <- as.integer(kyphosis$Start)
str(kyphosis)
modelo <- rpart(kyphosis$Kyphosis ~.,method = "class", data = kyphosis)
summary(modelo)

# Para examinar o resultado de uma árvore de decisao, existem diversas funcões, mas você pode usar printcp()
printcp(modelo)

# Visualizando a ávore (execute uma função para o plot e outra para o texto no plot)
# Utilize o zoom para visualizar melhor o gráfico
plot(modelo, uniform = TRUE)
text(modelo, use.n = TRUE, all = TRUE)

# Este outro pacote faz a visualizaco ficar mais legivel
install.packages('rpart.plot')
library(rpart.plot)
prp(modelo)