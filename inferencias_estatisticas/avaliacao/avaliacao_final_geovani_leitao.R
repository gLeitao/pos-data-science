dados <- read.csv("Dados.csv", header = TRUE, sep = ";", dec = ",")
library(normtest)
library(tidyr)
library(dplyr)

#Quetao 1

# a) O salario medio dos homens se difere do salario medio das mulheres

#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
shapiro.test(dados$salario[dados$sexo == 0])
shapiro.test(dados$salario[dados$sexo == 1])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade.

# h0 - a media do salario das mulheres e igual a media do salario dos homens
# h1  - a media do salario das melhores e diferente da media do salario dos homens
t.test(dados$salario ~ dados$sexo, var.equal = TRUE)
# Conclusao - como o p-value = 4.98e-16 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das mulheres e diferente da media do salario dos homens



# b) O Salario medio das pessoas nao brancas se difere das pessoas brancas

#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
shapiro.test(dados$salario[dados$cor == 0])
shapiro.test(dados$salario[dados$cor == 1])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade.

# h0 - a media do salario das pessoas nao brancas e igual a media do salario dos brancas
# h1  - a media do salario das pessoas nao brancas e diferente da media do salario dos brancas
t.test(dados$salario ~ dados$cor, var.equal = TRUE)
# Conclusao - como o p-value = 4.144e-06 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das pessoas nao brancas e diferente da media do salario das pessoas brancas



# c) O Salario medio das pessoas casadas se difere das pessoas solteiras

#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
shapiro.test(dados$salario[dados$est_civil == 0])
shapiro.test(dados$salario[dados$est_civil == 1])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade.

# h0 - a media do salario das pessoas casadas e igual a media do salario pessoas solteiras
# h1  - a media do salario das pessoas casadas e diferente da media do salario pessoas solteiras
t.test(dados$salario ~ dados$est_civil, var.equal = TRUE)
# Conclusao - como o p-value = 0.000236 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do salario das pessoas casadas e diferente da media do salario das pessoas solteiras



# d) Considerando  o  sexo  das  pessoas  e  seu  estado  civil conjuntamente,  e possivel  afirmar  que algumas dos grupos formados possui media salarial diferente dos demais?

dados_filtrados <- dados %>%
                   mutate(grupo = paste(sexo, est_civil, sep="-"))


shapiro.test(dados_filtrados$salario[dados_filtrados$grupo == '0-0'])
shapiro.test(dados_filtrados$salario[dados_filtrados$grupo == '1-0'])
shapiro.test(dados_filtrados$salario[dados_filtrados$grupo == '1-1'])
shapiro.test(dados_filtrados$salario[dados_filtrados$grupo == '0-1'])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade para todos os grupos

# Teste ANOVA de 4 grupos
# h0 - a media dos grupos sao iguais
# h1 - ha diferenca entre as medias dos grupos

ANOVA <- aov(dados_filtrados$salario ~ dados_filtrados$grupo)
summary(ANOVA)
# Conclusao - como o p-value = (Pr(>F)) = 02e-16 < 0,05 = alpha, rejeitamos h0 e aceitamos h1, logo existe pelo menos dois grupos que possuem as medias diferentes entre si



# e) O tempo de experiencia medio é diferente para homens e mulheres

#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
shapiro.test(dados$experiencia[dados$sexo == 0])
shapiro.test(dados$experiencia[dados$sexo == 1])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade.

# h0 - o tempo medio de experiencia da mulher e igual ao tempo medio de experiencia do homem
# h1  - o tempo medio de experiencia da mulher e diferente ao tempo medio de experiencia do homem
t.test(dados$experiencia ~ dados$sexo, var.equal = TRUE)
# Conclusao - como o p-value = 0.4164 > 0,05 = alpha, Aceitamos h0 e rejeitamos h1, logo o tempo medio de experiencia das mulheres e igual ao tempo medio de experiencia dos homens



# f) A idade media dos casados e diferente da idade media dos solteiros

#Pressuposto de normalidade (H0: distribuicao de e normal e H1: distribuicao nao e normal)
shapiro.test(dados$idade[dados$est_civil == 0])
shapiro.test(dados$idade[dados$est_civil == 1])
# Conclusao apesar de falhar no teste, devido ao volume de dados iremos assumir que tende a normalidade.

# h0 - a idade media dos casados e igual a idade media dos solteiros
# h1  - a idade media dos casados e diferente a idade media dos solteiros
t.test(dados$idade ~ dados$est_civil, var.equal = TRUE)
# Conclusao - como o p-value = 1.296e-08 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a idade media dos casados e diferente da idade media dos solteiros



#Questao 2

# g) ha relacoes entre salario e experiencia 

plot(dados$experiencia, dados$salario, xlab = "Experiencia", ylab = "Salario", main = "Salario X Experiencia")
abline(h=mean(dados$salario), v=mean(dados$experiencia), col = "blue")

# h0 - não existe correlacao entre salario e experiencia
# h1 - existe correlacao entre salario e experiencia
cor.test(dados$salario, dados$experiencia, method = "pearson")
# conclusao: como o p-value = 3.882e-10 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)
# por consequencia, podemos afirmar que a correlacao e positiva, ou seja, quanto maior for o salario, maior sera a experiencia.


# h0 - não existe correlacao entre salario e experiencia
# h1 - existe correlacao entre salario e experiencia
cor.test(dados$salario, dados$experiencia, method = "spearman")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)

# h0 - não existe correlacao entre salario e experiencia
# h1 - existe correlacao entre salario e experiencia
cor.test(dados$salario, dados$experiencia, method = "kendall")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)



# h) ha relacoes entre salario e tempo de instrucao

plot(dados$instrucao, dados$salario, xlab = "Tempo de Instrucao", ylab = "Salario", main = "Salario X Tempo de Instrucao")
abline(h=mean(dados$salario), v=mean(dados$instrucao), col = "blue")

# h0 - não existe correlacao entre salario e tempo de instrucao
# h1 - existe correlacao entre salario e tempo de instrucao
cor.test(dados$salario, dados$instrucao, method = "pearson")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)
# por consequencia, podemos afirmar que a correlacao e positiva, ou seja, quanto maior for o salario, maior sera o tempo de instrucao.


# h0 - não existe correlacao entre salario e tempo de instrucao
# h1 - existe correlacao entre salario e tempo de instrucao
cor.test(dados$salario, dados$instrucao, method = "spearman")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)

# h0 - não existe correlacao entre salario e tempo de instrucao
# h1 - existe correlacao entre salario e tempo de instrucao
cor.test(dados$salario, dados$instrucao, method = "kendall")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)



# i) ha relacoes entre salario e idade 

plot(dados$idade, dados$salario, xlab = "Idade", ylab = "Salario", main = "Salario X Idade")
abline(h=mean(dados$salario), v=mean(dados$idade), col = "blue")

# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$salario, dados$idade, method = "pearson")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)
# por consequencia, podemos afirmar que a correlacao e positiva, ou seja, quanto maior for o salario, maior sera a idade.


# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$salario, dados$idade, method = "spearman")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)

# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$salario, dados$idade, method = "kendall")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)



# j) ha relacoes entre experiencia e idade 

plot(dados$experiencia, dados$idade, xlab = "Idade", ylab = "Experiencia", main = "Experiencia X Idade")
abline(h=mean(dados$idade), v=mean(dados$experiencia), col = "blue")

# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$experiencia, dados$idade, method = "pearson")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)
# por consequencia, podemos afirmar que a correlacao e positiva, ou seja, quanto maior for a experiencia, maior sera a idade.


# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$experiencia, dados$idade, method = "spearman")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)

# h0 - não existe correlacao entre salario e idade
# h1 - existe correlacao entre salario e idade
cor.test(dados$experiencia, dados$idade, method = "kendall")
# conclusao: como o p-value = 2.2e-16 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)



# Questao 3

#modelo de regressao 
#estimacao
modelo <- lm(dados$salario ~ dados$sexo + dados$cor + dados$est_civil + dados$instrucao + dados$experiencia + dados$idade)
summary(modelo)

# k) Sabendo que as variaveis B1, B2 e B3 sao todas variaveis dummies, qual deveria ser a interpretacao dada destes coeficientes sobre salario 
# R - Variaveis tipo dummy o modelo pode levar ou nao em consideracao a suas classes, por exemplo, estado civil, o modelo pode levar em conta apenas as pessoas casadas e desconsiderar as solteiras.

# l) Qual e o poder explicativo do modelo (percentual de variancia explicada)
# R - R^2 foi igual a 0,3233, ou seja as variaveis explicam 32,33% da variacao do salario.

# m) De modo geral, o modelo foi significativo
# R - Pelo o Teste F-statistic(ANOVA), o modelo e no geral significativo a 5% (0,05) por o p-value= 2.2e-16.

# n) E possivel afirmar que o grau de instrucao do individuo afeta siginificativamente no seu salario? A que nivel de significancia?
# R - Sim, o grau de instrucao possui uma significancia de 0.001.

# o) E possivel afirmar que o estado civil do individuo afeta siginificativamente no seu salario? A que nivel de significancia?
# R - Sim, o estado civil possui uma significancia 0.05.

# p) E possivel afirmar que a experiencia do individuo afeta siginificativamente no seu salario? A que nivel de significancia?
# R - Sim, a experiencia possui uma significancia 0.001.

# q) E possivel afirmar que o sexo do individuo afeta siginificativamente no seu salario? A que nivel de significancia?
# R - Sim, o sexo possui uma significancia 0.001.

# r) Considere o modelo de modo geral, principalmente os sinais de cada um dos coeficientes do modelo de regressao, os resultados fazem sentido conceitualmente pra voce? Justifique.
# R - Faz sentido pois, em analises descritivas feitas anteriormente, 
#     mostram que ha desbalanceamento nos valores de salario quando comparados de pessoas brancas e nao brancas e tambem de homens e mulheres. 
#     Com isso os coeficientes sao ajustados a modo que suavise o melhor possivel essa diferença existentes entre as classes.



