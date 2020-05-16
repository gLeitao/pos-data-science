# Antes de come?ar, lembrar de mudar o diret?rio
# use o getwd() para saber o diret?rio atual, e
# use o setwd() para definir o novo endere?o

#getwd()
#setwd("C:/Users/Usuario/OneDrive - FURB/PPGBio/Aula 6")
install.packages("car")
install.packages("gdata")
require(gdata)

# Exemplos dos teste de hip?teses
# Para essa aula ser?o usados dos dados na form .csv

# Teste de normalidade
testnorm <- read.csv("Dados Exemplos Norm.csv", header = TRUE, sep = ";", dec = ".")

      ## Instalando o Pacote para o teste de normalidade.
  install.packages("normtest")
  library(normtest)

## Iniciamente mostraremos o resultado no gr?fico QQ-Plot
  qqnorm(testnorm$Produ??o, main= "", xlab="Quantis Te?ricos N(0,1)", ylab="Produ??o Agricola")
    qqline(testnorm$Produ??o, col="red")

  
## Testes de normalidade de Kolmogorov-Smirnov
  t_KS <- ks.test(testnorm$Produ??o, "pnorm")
  t_KS$statistic
  t_KS$p.value

## Teste de Normalidade de Shapiro-Wilk
  t_SW <- shapiro.test(testnorm$Produ??o)
  t_SW$statistic
  t_SW$p.value

## Construindo uma tabela de resultados
  testes <- c(t_KS$method, t_SW$method)
  estatistica <- as.numeric(c(t_KS$statistic,t_SW$statistic))
  valorp <- c(t_KS$p.value,t_SW$p.value)
  Resultados <- cbind(estatistica,valorp)
  rownames(Resultados) <- testes
  colnames(Resultados) <- c("Estat?stica","p")
  print(Resultados, digits = 5)

########################
# Exemplo de teste t para amostras independentes
########################

# Carregando os dados
  test_t_ind <- read.csv("Dados Exemplos Teste t ind.csv", header = TRUE, sep = ";", dec = ".") 
  
# Execu??o do Teste
  t.test(test_t_ind$peso_comida~test_t_ind$sexo, var.equal=TRUE)

  
    ########################
# Exemplo de teste t para amostras pareadas
########################   

  # Carregando os dados
  test_t_par <- read.csv("Dados Exemplos Teste t par.csv", header = TRUE, sep = ";", dec = ".") 
  
  # Execu??o do Teste
  t.test(test_t_par$Antes, test_t_par$Depois, paired = TRUE, var.equal=TRUE)  
  
########################
# Exemplo de teste ANOVA
########################   

  # Carregando os dados
  test_ANOVA <- read.csv("Dados Exemplos ANOVA.csv", header = TRUE, sep = ";", dec = ".")
  
  # Execu??o do Teste
  anova <- aov(test_ANOVA$tx_Hemo~test_ANOVA$Grupo, data = test_ANOVA)
  summary(anova)
  boxplot(test_ANOVA$tx_Hemo~test_ANOVA$Grupo)
  
  
########################
# Exemplo de teste Chi-Square
########################  
  
  # Carregando os dados
  test_Chi.Square <- read.csv("Dados Exemplos Chi-Square.csv", header = TRUE, sep = ";", dec = ".")
  
  # Tabela de Conting?ncias
  Cont <- table(test_Chi.Square$Tratamento, test_Chi.Square$Dor_Abdomen)
  rownames(Cont) <- c("Tratamento", "Controle")
  colnames(Cont) <- c("Com Dor","Sem Dor")
  Cont
  
  # realiza??o do Teste
  Chi2 <- chisq.test(Cont)
  Chi2
  
########################
# Testes N?o Param?tricos
########################
  
  kw_test <- kruskal.test(test_ANOVA)
  kw_test
  
  mw_test <- wilcox.test(test_t_ind$sexo, test_t_ind$peso_comida)
  mw_test
  
  wil_test <- wilcox.test(test_t_par$Antes, test_t_par$Depois)
  wil_test
  