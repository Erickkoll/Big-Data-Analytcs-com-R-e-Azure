# Lista de Exercícios - Capítulo 3

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/FCD/BigDataRAzure/Cap02")
getwd()

# Exercício 1 - Pesquise pela função que permite listar todos os arquivo no diretório de trabalho
list.files()


# Exercício 2 - Crie um dataframe a partir de 3 vetores: um de caracteres, um lógico e um de números
df <- data.frame(c("Hello World",7%%2 == 1,67))

# Exercício 3 - Considere o vetor abaixo. 
# Crie um loop que verifique se há números maiores que 10 e imprima o número e uma mensagem no console.

# Criando um Vetor
vec1 <- c(12, 3, 4,10, 19, 34)
vec1
for(i in vec1){
  print(i)
  ifelse(i>10,print('Esse número é maior que 10'),ifelse(i==10,print('Esse número é 10'),print('Esse número é menor do que 10')))
}


# Exercício 4 - Conisdere a lista abaixo. Crie um loop que imprima no console cada elemento da lista
lst2 <- list(2, 3, 5, 7, 11, 13)
lst2
for(i in lst2){
  print(i)
}
  


# Exercício 5 - Considere as duas matrizes abaixo. 
# Faça uma multiplicação element-wise e multiplicação normal entre as materizes
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1
mat2 <- t(mat1)
mat2
# Multiplicação element-wise
RmatEw <- mat1 * mat2
print('A multiplicação element-wise das matrizes é')
RmatEw
# Multiplicação de matrizes
RmatNm <- mat1 %*% mat2
print('A multiplicação normal das matrizes é')
RmatNm

# Exercício 6 - Crie umvetor, matriz, lista e dataframe e faça a nomeação de cada um dos objetos
vec <- c(1,2,3)
vec
mat <- matrix(seq(3, 27, by =3),nrow = 3, ncol=3)
mat
lista <- list("Oi",4,3==2)
lista
df1 <- data.frame(c("vetor","matriz","lista"),c(vec,mat,lista))
df1
View(df1)

# Exercício 7 - Considere a matriz abaixo. Atribua valores NA de forma aletória para 50 elementos da matriz
# Dica: use a função sample()
mat2 <- matrix(1:90, 10)
mat2
idmat <- sample(1:nrow(mat2)*ncol(mat2),50,replace=TRUE)
mat2[idmat] <- NA
mat2



# Exercício 8 - Para a matriz abaixo, calcule a soma por linha e por coluna
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1
apply(mat1,1,sum)
apply(mat1,2,sum)

# Exercício 9 - Para o vetor abaixo, ordene os valores em ordem crescente
a <- c(100, 10, 10000, 1000)
a
as.vector(apply(matrix(a, nrow=1),1,sort))

# # Exercício 10 - Imprima no console todos os elementos da matriz abaixo que forem maiores que 15
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1

for(i in mat1){
  if(i>15){print(i)}
}
