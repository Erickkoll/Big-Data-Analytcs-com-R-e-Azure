# Estatística na Prática 5 - O Que Fazer Quando a Suposição do Teste Estatístico Não é Satisfeita?

# Leia os manuais em pdf no Capítulo 12 do curso.

# Há diferença significativa no crescimento dos dentes de acordo com o tipo de suplemento
# usado nos Porcos da Guiné?

# Imports
install.packages("GGally")
library(ggplot2)
library(GGally)
library(dplyr)

# Compreendendo o dataset
?ToothGrowth

# Carregando o dataset
data("ToothGrowth")
str(ToothGrowth)
View(ToothGrowth)
summary(ToothGrowth)

# Histograma da variável len
hist(ToothGrowth$len)

# GGPairs
?ggpairs
ggpairs(ToothGrowth)

# Boxplots por tipo de suplemento
qplot(supp,
      len,
      data = ToothGrowth, 
      main = "Crescimento dos Dentes dos Porcos da Guiné Por Tipo de Suplemento",
      xlab = "Tipo de Suplemento", 
      ylab = "Comprimento do Dente") + 
  geom_boxplot(aes(fill = supp))

# Analisando os boxplots parece haver uma diferença no crescimento dos dentes, associada ao
# tipo de suplemento. Precisamos validar.

# Há diferença significativa no crescimento dos dentes de acordo com o tipo de suplemento
# usado nos Porcos da Guiné?

ToothGrowth_VC <- ToothGrowth %>% filter(supp == "VC")
ToothGrowth_OJ <- ToothGrowth %>% filter(supp == "OJ")

resultado <- t.test(ToothGrowth_VC$len,ToothGrowth_OJ$len, na.rm = TRUE)
resultado
