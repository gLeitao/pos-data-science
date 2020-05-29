#Questao 1

df_formacao <- read.csv("Avaliacao Formacao.csv", header = TRUE, sep = ";", dec = ".")

library(fBasics)
summary(df_formacao)

mean(df_formacao$Conhecimento_Antes)
mean(df_formacao$Conhecimento_Depois)

# Teste T de 2 amostras pareadas propriamente dito
# h0 - a media de antes e igual a media de depois
# h1 - a media de depois e diferente da media de antes
t.test(df_formacao$Conhecimento_Antes, df_formacao$Conhecimento_Depois, paired = TRUE)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, rejeitamos a H0, logo assumimos que ha diferenca estatisticamente siginificativa para o conhecimento de antes e depois


#-----------

#Questao 2

df_empresa <- read.csv("Clima Organizacional.csv", header = TRUE, sep = ";", dec = ".")

#Questao A)

mean(df_empresa$Salario[df_empresa$Sexo == 0])
mean(df_empresa$Salario[df_empresa$Sexo == 1])

# h0 - a media do salario das mulheres e igual a media do salario dos homens
# h1  - a media do salario das melhores e diferente da media do salario dos homens
t.test(df_empresa$Salario ~ df_empresa$Sexo)
# conclusao - como o p-value = 2.301e-09 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das mulheres e diferente da media do salario dos homens


#Questao B)

mean(df_empresa$Stress[df_empresa$Sexo == 0])
mean(df_empresa$Stress[df_empresa$Sexo == 1])

# h0 - a media de stress das mulheres e igual a media do salario dos homens
# h1  - a media de stress das melhores e diferente da media do salario dos homens
t.test(df_empresa$Stress ~ df_empresa$Sexo)
# conclusao - como o p-value = 2.2e-16 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media de stress das mulheres e diferente da media de stress dos homens


#-----------

#Questao 3

df_restaurante <- read.csv("Preco Comida.csv", header = TRUE, sep = ";", dec = ",")

mean(df_restaurante$Preco_Kg[df_restaurante$Comida == 1])
mean(df_restaurante$Preco_Kg[df_restaurante$Comida == 2])
mean(df_restaurante$Preco_Kg[df_restaurante$Comida == 3])

# Teste ANOVA de 3 grupos
# h0 - a media dos grupos sao iguais
# h1 - ha diferenca entre as medias dos grupos

ANOVA <- aov(df_restaurante$Preco_Kg ~ df_restaurante$Comida)
summary(ANOVA)
#conclusao - como o p-value = (Pr(>F)) = 02e-16 < 0,05 = alpha, rejeitamos h0 e aceitamos h1, logo existe pelo menos dois grupos que possuem as medias diferentes entre si

#visualizacao pelo box plot
boxplot(df_restaurante$Preco_Kg ~ df_restaurante$Comida)
