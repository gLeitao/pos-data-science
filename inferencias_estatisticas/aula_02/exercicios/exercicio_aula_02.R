#Questao 1

df_formacao <- read.csv("Avaliacao Formacao.csv", header = TRUE, sep = ";", dec = ".")

library(fBasics)
summary(df_formacao)

mean(df_formacao$Conhecimento_Antes)
mean(df_formacao$Conhecimento_Depois)


library(normtest)
#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
ks.test(df_formacao$Conhecimento_Antes, "pnorm")
ks.test(df_formacao$Conhecimento_Depois, "pnorm")
# importante para o teste t de 2 amostra e a normalidade das diferencas 

dif <- df_formacao$Conhecimento_Depois - df_formacao$Conhecimento_Antes
ks.test(dif, "pnorm")
# Obs.: quando trabalhamos com mais de 100 ou 150 casos, a normalidade po ser flexibilizada


# Teste T de 2 amostras pareadas propriamente dito
# h0 - a media de antes e igual a media de depois
# h1 - a media de depois e diferente da media de antes
t.test(df_formacao$Conhecimento_Antes, df_formacao$Conhecimento_Depois, paired = TRUE)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, rejeitamos a H0, logo assumimos que ha diferenca estatisticamente siginificativa para o conhecimento de antes e depois


wilcox.test(df_formacao$Conhecimento_Antes, df_formacao$Conhecimento_Depois, paired = TRUE)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, rejeitamos a H0, logo assumimos que ha diferenca estatisticamente siginificativa para o conhecimento de antes e depois


#-----------

#Questao 2

df_empresa <- read.csv("Clima Organizacional.csv", header = TRUE, sep = ";", dec = ".")

#Questao A)

summary(df_empresa$Salario[df_empresa$Sexo == 0])
summary(df_empresa$Salario[df_empresa$Sexo == 1])

# Pressuposto do teste
# Normalidade
shapiro.test(df_empresa$Salario[df_empresa$Sexo == 0])
shapiro.test(df_empresa$Salario[df_empresa$Sexo == 1])
# Conclusao aceitamos h0 e rejeitamos h1, logo as amostras para ambas as classes possuem distribuicao normal.

# Homogenidade das variancias
# usar o teste de levene: (H0 que as maostras tem variancias iguais; H1 as amostras tem variancias diferentes)
library(car)
leveneTest(df_empresa$Salario, df_empresa$Sexo)
# conclusao, aceitamos h0 e rejeitamos h1, logo as variancias sao iguais



# h0 - a media do salario das mulheres e igual a media do salario dos homens
# h1  - a media do salario das melhores e diferente da media do salario dos homens
t.test(df_empresa$Salario ~ df_empresa$Sexo, var.equal = TRUE)
# conclusao - como o p-value = 2.494e-09 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das mulheres e diferente da media do salario dos homens

# teste de mann-whitney - nao parametrico correspondente
wilcox.test(df_empresa$Salario ~ df_empresa$Sexo)
# conclusao - como o p-value = 5.613e-09 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das mulheres e diferente da media do salario dos homens


#Questao B)

summary(df_empresa$Stress[df_empresa$Sexo == 0])
summary(df_empresa$Stress[df_empresa$Sexo == 1])

# usar teste de 2 amostras independentes

# pressupostos
# normalidade (H0: distribuicao normal; H1: distribuicao nao e normal)
shapiro.test(df_empresa$Stress[df_empresa$Sexo == 0])
shapiro.test(df_empresa$Stress[df_empresa$Sexo == 1])
# conclusao, aceitamos h0 e rejeitamos h1, logo as distribuicao sao normais

# homogeneidade de variancia (H0: as amostras tem a mesma variancia; H1 as amostras tem variancias diferentes)
leveneTest(df_empresa$Stress, df_empresa$Sexo)
# conclusao, aceitamos h0 e rejeitamos h1, logo as variancias sao iguais

# h0 - a media de stress das mulheres e igual a media do salario dos homens
# h1  - a media de stress das melhores e diferente da media do salario dos homens
t.test(df_empresa$Stress ~ df_empresa$Sexo, var.equal = TRUE)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media de stress das mulheres e diferente da media de stress dos homens

# Teste nao parametrico - Mann Whitney
wilcox.test(df_empresa$Stress ~ df_empresa$Sexo)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media de stress das mulheres e diferente da media de stress dos homens


#-----------

#Questao 3

df_restaurante <- read.csv("Preco Comida.csv", header = TRUE, sep = ";", dec = ",")

summary(df_restaurante$Preco_Kg[df_restaurante$Comida == 1])
summary(df_restaurante$Preco_Kg[df_restaurante$Comida == 2])
summary(df_restaurante$Preco_Kg[df_restaurante$Comida == 3])

plot(df_restaurante$Preco_Kg, df_restaurante$Comida, xlab = "Preco", ylab = "Comida")
abline(h=c(1,2,3), col="red")

# pressupostos
#normalidade
shapiro.test(df_restaurante$Preco_Kg[df_restaurante$Comida == 1])
shapiro.test(df_restaurante$Preco_Kg[df_restaurante$Comida == 2])
shapiro.test(df_restaurante$Preco_Kg[df_restaurante$Comida == 3])
# conclusao, aceitamos h0 e rejeitamos h1, logo as as distribuicao sao normais

#homogenidade das variancias
leveneTest(df_restaurante$Preco_Kg, df_restaurante$Comida)
# conclusao, aceitamos h0 e rejeitamos h1, logo as variancias sao iguais

# Teste ANOVA de 3 grupos
# h0 - a media dos grupos sao iguais
# h1 - ha diferenca entre as medias dos grupos

ANOVA <- aov(df_restaurante$Preco_Kg ~ df_restaurante$Comida)
summary(ANOVA)
#conclusao - como o p-value = (Pr(>F)) = 02e-16 < 0,05 = alpha, rejeitamos h0 e aceitamos h1, logo existe pelo menos dois grupos que possuem as medias diferentes entre si

# teste nao parametrico - alternativo - teste de kruskal-wallis
kruskal.test(df_restaurante$Preco_Kg ~ df_restaurante$Comida)
#conclusao - como o p-value = (Pr(>F)) = 02e-16 < 0,05 = alpha, rejeitamos h0 e aceitamos h1, logo existe pelo menos dois grupos que possuem as medias diferentes entre si


#visualizacao pelo box plot
boxplot(df_restaurante$Preco_Kg ~ df_restaurante$Comida)
