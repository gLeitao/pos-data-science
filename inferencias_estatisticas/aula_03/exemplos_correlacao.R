df_peso <- read.csv("peso_altura.csv", header = TRUE, sep = ";", dec = ".")

#analise grafica preliminar 

plot(df_peso$Estatura, df_peso$Peso, xlab = "Altura", ylab = "Peso", main = "Peso X Altura das Mulheres")
abline(h=mean(df_peso$Peso), v=mean(df_peso$Estatura), col = "blue")

# Analise da normalidade
library(normtest)

shapiro.test(df_peso$Estatura)
shapiro.test(df_peso$Peso)
# conclusao todas as variaveis seguem a distribuicao normal

# Analise de correlacao
cor(df_peso$Estatura, df_peso$Peso, method = "pearson")
cor.test(df_peso$Estatura, df_peso$Peso, method = "pearson")
# conclusao: como o p-value = 0.0002812 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)
# por consequencia, podemos afirmar que a correlacao e positiva, ou seja, quanto maior for a altura maior e o peso.

# Correlacao de Spearman
cor.test(df_peso$Estatura, df_peso$Peso, method = "spearman")
# conclusao: como o p-value = 0.000597 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)

# Correlacao de Kendall
cor.test(df_peso$Estatura, df_peso$Peso, method = "kendall")
# conclusao: como o p-value = 0.001299 < 0.005=alpha, rejeitamos h0 (correlacao nao existente) e aceitamos h1 (existe correlacao)


#---------------------------------------

#Analise de modelo de regressao

#Analise grafica
plot(df_peso$Estatura, df_peso$Peso, xlab = "Altura", ylab = "Peso", main = "Peso X Altura das Mulheres")

#estimacao do mddelo lienar de previsao 
# equacao de regrecao: peso = b0 + b1*Altura
modelo <- lm(df_peso$Peso ~df_peso$Estatura)
summary(modelo)

# adicionando a projecao no grafico 
abline(modelo, col="red")


#outros graficos 
plot(modelo$fitted.values, modelo$residuals)
abline(h=0, col = "red")
