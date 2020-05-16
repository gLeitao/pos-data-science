# Antes de come?ar, lembrar de mudar o diret?rio
# use o getwd() para saber o diret?rio atual, e
# use o setwd() para definir o novo endere?o

# Baixar o Banco de Dados
dados <- read.csv("Exemplo VaR.csv", header = TRUE, sep = ";", dec = ",")
    
# Para aplicar o modelo de Value At Risk, precisase estimar o par?metros de uma curva Normal de Probabilidade
# Para Estimar a fun??o Densidade de Probabilidade e a Fun??o de Probabilidade
    
# Obtendo as m?dias
medias <- c(mean(dados$CEB), mean(dados$Petrobras), mean(dados$Marfrig), mean(dados$JBS))
medias

# Obtendo os Desvios-Padr?o
desvpad <- c(sd(dados$CEB), sd(dados$Petrobras), sd(dados$Marfrig), sd(dados$JBS))
desvpad

# Estimando o valor em risco da cada Empresa
VaR_CEB <- qnorm(0.05, mean = medias[1], sd = desvpad[1])
VaR_CEB

VaR_PET <- qnorm(0.05, mean = medias[2], sd = desvpad[2])
VaR_PET

VaR_MAR <- qnorm(0.05, mean = medias[3], sd = desvpad[3])
VaR_MAR

VaR_JBS <- qnorm(0.05, mean = medias[4], sd = desvpad[4])
VaR_JBS
      