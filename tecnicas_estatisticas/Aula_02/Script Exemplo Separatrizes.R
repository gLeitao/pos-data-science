# Antes de come?ar, lembrar de mudar o diret?rio
# use o getwd() para saber o diret?rio atual, e
# use o setwd() para definir o novo endere?o

#getwd()
#setwd("C:/Users/mmrodrigues/OneDrive - FURB/PPGBio/Aula 5")

# Para essa aula ser?o usados dos dados na form .csv

# Exemplo Separatrizes
  indEmpresas <- read.csv("Exemplo Separatrizes.csv", header = TRUE, sep = ";", dec = ",")

# Visualiza??o do Banco de Dados
  View(indEmpresas)
  names(indEmpresas)

# Estat?sticas Descritivas B?sicas
  
  # Para Liquidez Geral
    summary(indEmpresas$LG)
  
  # Para Imobiliza??o do Patrim?nio L?quido
    summary(indEmpresas$Imb_PL)
  
  # Para Participa??o do Capital de Terceiros
    summary(indEmpresas$Part_CT)
 
  # Para Giro do Ativo
    summary(indEmpresas$GA)
    
  # Para Margem L?quida
    summary(indEmpresas$ML)
    
  # Para Retorno Sobre Ativos
    summary(indEmpresas$ROA)
    
  # Para Retorno Sobre PL
    summary(indEmpresas$ROE)

#Medidas de dispers?o
  # Para Liquidez Geral
    sd(indEmpresas$LG)
    
  # Para Imobiliza??o do Patrim?nio L?quido
    sd(indEmpresas$Imb_PL)
    
  # Para Participa??o do Capital de Terceiros
    sd(indEmpresas$Part_CT)
    
  # Para Giro do Ativo
    sd(indEmpresas$GA)
    
  # Para Margem L?quida
    sd(indEmpresas$ML)
    
  # Para Retorno Sobre Ativos
    sd(indEmpresas$ROA)
    
  # Para Retorno Sobre PL
    sd(indEmpresas$ROE)

  # Para Retorno Sobre PL (Coeficiente de Variação)
    (sd(indEmpresas$ROE)/mean(indEmpresas$ROE))*100
    
    

 
