#Exemplo de regressao multipla

df_dados <- read.csv("Exemplo_Reg_Mult.csv", header = TRUE, sep = ";", dec = ".")

#exiplicacao da base
#KBI - indice de ocupacao dos cuidadores de idosos da coreio do sul
#ADL - Nivel de independencia do idoso em atividade do dia a dia
#MEM - Nivel de memoria do idoso (perda de memoria)
#COG - Nivel de capacidade cognitiva do idoso 

#estatisticas descritivas 
library(fBasics)
summary(df_dados$KBI)
summary(df_dados$ADL)
summary(df_dados$MEM)
summary(df_dados$COG)

#analise das correlacoes 
cor.test(df_dados$KBI, df_dados$ADL, method = "pearson")
cor.test(df_dados$KBI, df_dados$MEM, method = "pearson")
cor.test(df_dados$KBI, df_dados$COG, method = "pearson")

cor.test(df_dados$ADL, df_dados$COG, method = "pearson")
cor.test(df_dados$ADL, df_dados$MEM, method = "pearson")
cor.test(df_dados$MEM, df_dados$COG, method = "pearson")


#modelo de regressao 
#estimacao
modelo <- lm(df_dados$KBI ~ df_dados$ADL+df_dados$MEM+df_dados$COG)
summary(modelo)

#Analise dos resultados: os coeficientes do Interceptor (constantes), e memoria foram significativos a 5% (0,005), 
# o coeficiente da dependencia de atividade (ADL) foi significativo a 10% (0,1)

#teste ANOVA: o modelo e no geral siginificativo a 5% (0,05) por o p-value = 3.9*10-1
#R^2 foi igual a 0,2868, ou seja as variaveis de ADDL, MEM, COG explicam 28,68% da variacao da taxa de ocupacao do cuidador de idoso.

#Pressuposto da regressao 
#Normalidade dos residuos
library(normtest)
jb.norm.test(modelo$residuals)

#Autocorrelacao Serial (Durbin-Whatson)
library(lmtest)
dwtest(modelo)

#Multicolinearidade (VIF)
vif(modelo)

#Heterocedasticidade dos residuos (Breuch-Pagan)
#H0 a variancia dos residous e constante para todo o intervalo de estimacao
#H1 a variancia dos residous nao e constante para todo o intervalo de estimacao
bptest(modelo)


#graficos
plot(df_dados$KBI, modelo$fitted.values)
abline(lm(modelo$fitted.values ~ df_dados$KBI), col = "red")
