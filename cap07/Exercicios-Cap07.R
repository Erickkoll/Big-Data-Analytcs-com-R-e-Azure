# Solução Lista de Exercícios - Capítulo 7 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/cap07")
getwd()

# Formatando os dados de uma página web
library(rvest)
library(stringr)
library(tidyr)

# Exercício 1 - Faça a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I
url <- "http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I"
webpage <- read_html(url)
webpage

# Exercício 2 - Da página coletada no item anterior, extraia o texto que contenha as tags:
# "#detailed-forecast-body b  e .forecast-text"
results <- html_nodes(webpage,"#detailed-forecast-body b, .forecast-text") %>% html_text

# Exercício 3 - Transforme o item anterior em texto

texto <- paste(results, collapse = " ")

# Exercício 4 - Extraímos a página web abaixo para você. Agora faça a coleta da tag "table"
url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)
tabela <- html_nodes(pagina, 'table')
class(tabela)


# Exercício 5 - Converta o item anterior em um dataframe
tab <- html_table(tabela)[[1]]
head(tab)

# Exercício 6 - Remova as duas primeiras linhas e adicione nomes as colunas
tab <- tab[-(1:1),]
colnames(tab) <- tab[1,]
tab <- tab[-1,]
tab

# Exercício 7 - Converta de algarismos romanos para números inteiros
install.packages("numbers")
library(numbers)
tab[,1] <- roman2int(tab[,1])

# Exercício 8 - Divida as colunas em 4 colunas
tab$NO. <- 1:57
View(tab)
tab$DATE <- as.Date(tab$DATE, "%B. %d, %Y")
View(tab)

# Exercício 9 - Inclua mais 2 colunas com o score dos vencedores e perdedores
# Dica: Você deve fazer mais uma divisão nas colunas
tab <- separate(tab, RESULT, c('vencedores','perdedores'), sep = ', ', remove= TRUE)
View(tab)
padrao <- " \\d+$"
tab$pontosvencedor <- as.numeric(str_extract(tab$vencedores, padrao))
tab$pontosperdedor <- as.numeric(str_extract(tab$perdedores, padrao))
tab$vencedores <- gsub(padrao, "", tab$vencedores)
tab$perdedores <- gsub(padrao, "", tab$perdedores)
View(tab)

# Exercício 10 - Grave o resultado em um arquivo csv
write.csv(tab, 'futebol.csv', row.names = F)
dir()


