# ______________________________________________
#
#           Script da Aula de 04/04/2020
#
# ______________________________________________

#1 Primeiro passo - Mudar o diretArio

#2 Baixar o banco de dados
#   Neste caso serA um arquivo ".csv"

Municipios<-read.csv("Municipios_SC.csv", sep=",", dec=",", header=T)

#3 buscar o nome das variAveis da base de dados
names(Municipios)

#4 calcular a mAdia para a variAvel peso
mean(Municipios$Populacao)
mean(Municipios$Area)
mean(Municipios$Densidade)

#5 calcular a mediana para a variAvel peso
median(Municipios$Populacao)
median(Municipios$Area)
median(Municipios$Densidade)

#6 gerar uma estatAstica geral da variAvel peso  
summary(Municipios$Populacao)
summary(Municipios$Area)
summary(Municipios$Densidade)

# Alternativa para o "Run" A "Ctrl + Enter"


#7 Para calcular os percentis
#os valores internos ao vetor c, indicam as proporcaes dos percentis
quantile(Municipios$Populacao, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))
quantile(Municipios$Area, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))
quantile(Municipios$Densidade, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))

#8 Medidas de dispersAo
#Amplitude
max(Municipios$Populacao)
max(Municipios$Area)
max(Municipios$Densidade)
min(Municipios$Populacao)
min(Municipios$Area)
min(Municipios$Densidade)
# Amplitude Populacao
max(Municipios$Populacao)-min(Municipios$Populacao)
# Amplitude Area
max(Municipios$Area)-min(Municipios$Area)
# Amplitude Densidade
max(Municipios$Densidade)-min(Municipios$Densidade)

#Desvio-PadrAo
sd(Municipios$Populacao)
sd(Municipios$Area)
sd(Municipios$Densidade)

#VariAncia
var(Municipios$Populacao)
var(Municipios$Area)
var(Municipios$Densidade)

#Coeficiente de VariAncia
sd(Municipios$Populacao)/mean(Municipios$Populacao)
sd(Municipios$Area)/mean(Municipios$Area)
sd(Municipios$Densidade)/mean(Municipios$Densidade)

#Existe pacotes que fazem o cAlculo geral para todas as EstatAsticas
# A preciso instalar o pacote "fBasics"
library(fBasics) 
basicStats(Municipios$Populacao)
basicStats(Municipios$Area)
basicStats(Municipios$Densidade)

#Histogramas
hist(Municipios$Populacao,  breaks = 100, xlab="Populacao", ylab="")
hist(Municipios$Area ,  breaks = 50, xlab="Area", ylab="")
hist(Municipios$Densidade ,  breaks = 500, xlab="Densidade", ylab="")

# Normalizacao pelo Logaritmo
# Aplicando o log sobre as variAveis de populacao

ln_Pop=log(Municipios$Populacao)
hist(ln_Pop,  breaks = 10, xlab="Populacao", ylab="")

ln_Area=log(Municipios$Area)
hist(ln_Area,  breaks = 10, xlab="Populacao", ylab="")

ln_Dens=log(Municipios$Densidade)
hist(ln_Dens,  breaks = 10, xlab="Populacao", ylab="")

