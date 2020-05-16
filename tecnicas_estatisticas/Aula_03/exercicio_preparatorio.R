df <- read.csv("Exercício Preparatório.csv", header = TRUE, sep = ";", dec = ".")

#Questao 1 - as medidas de tendecia das variaveis numericas (min, max, 1 e 3 quartil, mediana e media)
summary(df$salario)
summary(df$idade)
summary(df$stress)

#Questao 2 - as medidas de dispersao das variaveis numericas (amplitude, desvio-padrao, variancia, coeficiene de variacao, assimetria e curtose)
library("fBasics") 
basicStats(df$salario)
max(df$salario) - min(df$salario) #amplitude
basicStats(df$idade)
max(df$idade) - min(df$idade) #amplitude
basicStats(df$stress)
max(df$stress) - min(df$stress) #amplitude

#Questao 3 - calcule a media e a mediana para salarios de homens e mulheres separadamente
df_mulher <- df[df$sexo == 1,]
summary(df_mulher$salario)

df_homem <- df[df$sexo == 0,]
summary(df_homem$salario)

#Questao 4 - calcule o desvio-padrao e o coeficiente de variacao para homens e mulheres separadamente e verifique se existe diferenca nas variacoes
sd(df_mulher$salario)
sd(df_mulher$idade)
sd(df_mulher$stress)

sd(df_mulher$salario)/mean(df_mulher$salario)
sd(df_mulher$idade)/mean(df_mulher$idade)
sd(df_mulher$stress)/mean(df_mulher$stress)

sd(df_homem$salario)
sd(df_homem$idade)
sd(df_homem$stress)

sd(df_homem$salario)/mean(df_homem$salario)
sd(df_homem$idade)/mean(df_homem$idade)
sd(df_homem$stress)/mean(df_homem$stress)

#Questao 5 - calcule a media e a mediana do salario para casados e solteiros separadamente 
df_solteiro <- df[df$est_civil == 0,]
summary(df_solteiro$salario)

df_casado <- df[df$est_civil == 1,]
summary(df_casado$salario)


#Questao 6 - calcule a media e a mediana do nivel de stress para homems e mulheres separadamente
summary(df_mulher$stress)
summary(df_homem$stress)

#Questao 7 - calcule a media e a mediana do nivel de stress para casados e solteiros separadamente
summary(df_solteiro$stress)
summary(df_casado$stress)

#Questao 8 - faca um grafico de dispersao que compare o nivel de stress com o salario do entrevistado
plot(df$salario, df$stress)

#Questao 9 - faca um grafico de dispersao que comare o nivel de stress com a idade do entrevistado
plot(df$idade, df$stress)

#Questao 10 - faca um boxplot das variaveis numericas e verifique se existe presenca de outliers
boxplot(df$salario)
boxplot(df$idade)
boxplot(df$stress)

#Questao 11 - considerando a media e o desvio-padrao para as mulheres, verifique qual a probabilidade de uma mulher receber acima do 3 quartil. E qual as chances de um homem? assuma a distrubuicao normal para os dados
mediam <- mean(df_mulher$salario)
desvm <- sd(df_mulher$salario)
q3m <- quantile(df_mulher$salario, c(0.75))

1-pnorm(q3m, mean = mediam, sd = desvm)

mediah <- mean(df_homem$salario)
desvh <- sd(df_homem$salario)
q3h <- quantile(df_homem$salario, c(0.75))
  
1-pnorm(q3h, mean = mediah, sd = desvh)

#Questao 12 - considerando a  distribuicao normal, com media e o desvio-padrao dos casados, quais a changes do nivel de stress de um destes respondentes ser menor doque 50 (metade da escala).

mediac <- mean(df_casado$stress)
desvc <- sd(df_casado$stress)

pnorm(50, mean = mediac, sd = desvc)
