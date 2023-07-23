# Estatística na Prática 4 - Análise, Interpretação e Exercício com Teste do Qui-Quadrado

# Leia os manuais em pdf no Capítulo 11 do curso.

setwd("C:/Users/erick/OneDrive/Área de Trabalho/Programação/Big Data Analytcs com R e Azure/Cap11")
getwd()

# Suposição do teste:
# As variáveis devem ser independentes!
library('dplyr')

# Carregando o dataset
df = read.csv("dados.csv")

# Visualizando os dados
View(df)

# Dimensões
dim(df)

# Separando x e y
df <- df %>% filter(Tipo_Imovel != c("Apartamento"))
x = df$Tipo_Imovel
unique(x)

y = df$Status_Imovel
unique(y)

# Tabela cruzada
table(x, y)
prop.table(table(x, y))

# Definindo as hipóteses:

# H0 = Não há relação entre x e y
# H1 = x e y estão relacionados

# Se o valor-p for menor que 0.05 rejeitamos a H0

# Teste do Qui-Quadrado
?chisq.test
chisq.test(table(x, y))

# Exercício:

# Se não considerarmos os imóveis do tipo Apartamento, há diferença no resultado do teste?



