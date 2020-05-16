# Exemplo de teste T 1 amostra de media fixa

# caso da carga horaria dos executivos
dados = c(44,43,45,46,48,40,43,44,45,46,44,40,42,41,43,42,48,46,45,44)

# t_calc = (media amostral - media hipotetica) / desvio padrao/raiz(numero de observacoes)
media_amostral = mean(dados)
media_hipotetica = 44
desvadp = sd(dados)

t_calc=(media_amostral - media_hipotetica)/(desvadp/20^0.5)

p_value = 2 * (1-pt(abs(t_calc), 20-1))


# trabalhando com a funcao t.teste
# H0 - a media da amostra e igual a media hipotetica
# H1 - a media da amostra e diferente da media hipotetica 

#calculo do teste
t.test(x=dados, mu = media_hipotetica)

# Conclusao - como o p_value = 0,923 > 0,05 = alpha Nao rejeitamos H0, Logo podemos conseiderar que os executivos investigados trabalham em media 44 horas semanais

# Pressuposto de normalidade do Teste T
  #H0 - Distribucao dos dados e normal
  #H1 - Distribuicao dos dados nao e normal 
  # Teste de normalidade de Shapiro-Wilk
  library(normtest)
  shapiro.test(dados)
  
  # Conclusao como o p_value = 0,5973 > 0,05 = alpha, nao rejeitamos H0, Logo a distribuicao dos dados segue a normalidade
  
  
  #-------------------------------------------------------------------------------------
  
dados_par <- read.csv("Dados Exemplos Teste t par.csv", header = TRUE, sep = ";", dec = ".")

library(fBasics)

basicStats(dados_par$Antes)
basicStats(dados_par$Depois)

# Pressuposto do teste
# normalidade - shapiro-wilk
# h0 - a distribuicao dos dados e normal
# h1 - a distribuicao dos dados nao e normal
shapiro.test(dados_par$Antes)  
# conclusao - cpmp o p-value = 0,9951 > 0,05 = alpha, nao rejeitamos h0, logo a distribuicao de daos segue a normalidade
shapiro.test(dados_par$Depois)  
# conclusao - cpmp o p-value = 0,6982 > 0,05 = alpha, nao rejeitamos h0, logo a distribuicao de daos segue a normalidade

dif = dados_par$Antes - dados_par$Depois
shapiro.test(dif)

# Teste T de 2 amostras pareadas propriamente dito
# h0 - a media de antes e igual a media de depois
# h1 - a media de depois e diferente da media de antes
t.test(dados_par$Antes, dados_par$Depois, paired = TRUE)
# conclusao - como o p-value = 0,07774 > 0,05 = alpha, nao rejeitamos a H0, logo assumimos que nao ha diferenca estatisticamente siginificativa para o peso dos indivods antes e depois da dieta


# se for o caso de um teste unicaudal, o processo seria o seguinte:
# h0 - a media de antes e igual a media de depois
# h1 - a media de antes e maior da media de depois
t.test(dados_par$Antes, dados_par$Depois, paired = TRUE, alternative = "greater")
# conclusao - como o p-value = 0,03887 < 0,05 = alpha, nos rejeitamos a h0 e aceitamos h1, logo a media do peso antes e maior que a media do peso depois



#-----------------------------------

# teste T de duas amostras independentes

dados_ind <- read.csv("Dados Exemplos Teste t ind.csv", header = TRUE, sep = ";", dec = ",")

# estatistica basica
#Geral
basicStats(dados_ind$peso_comida)
#mulheres
basicStats(dados_ind$peso_comida[dados_ind$sexo == 1])
#homens
basicStats(dados_ind$peso_comida[dados_ind$sexo == 0])


# pressupostos do teste T
# normalidade dos grupos - shapiro-wilk teste

#mulheres
shapiro.test(dados_ind$peso_comida[dados_ind$sexo==1])
#conclusao - como o p-value = 0,9098 > 0,05 = alpha, nao rejeitamos a h0, logo a distribuicao do dados pode ser assumida como normal para as mulheres

#homens
shapiro.test(dados_ind$peso_comida[dados_ind$sexo==0])
#conclusao - como o p-value = 0,7883 > 0,05 = alpha, nao rejeitamos a h0, logo a distribuicao do dados pode ser assumida como normal para as homens


# homogenidades das variancias
library(car)

leveneTest(dados_ind$peso_comida, dados_ind$sexo, center = mean)


#teste t de duas amostrar independentes propriamente dito
# teste bicaudal
# h0 - a media do peso da comida das mulheres e igual a media do peso da comida dos homens
# h1  - a media do peso da comida das melhores e diferente da media do peso da comida dos homens
t.test(dados_ind$peso_comida ~ dados_ind$sexo)
# conclusao - como o p-value = 0,007583 < 0,05 = alpha, Rejeitamos h0 e aceitamos h1, logo a media do peso da comida das mulheres e diferente da media do peso da comida dos homens



#-----------------------------------
dados_anova <- read.csv("Dados Exemplos ANOVA.csv", header = TRUE, sep = ";", dec = ".")

#estatisticas descritivas
basicStats(dados_anova$tx_Hemo)

basicStats(dados_anova$tx_Hemo[dados_anova$Grupo==1])
basicStats(dados_anova$tx_Hemo[dados_anova$Grupo==2])
basicStats(dados_anova$tx_Hemo[dados_anova$Grupo==3])

# pressupostos 
# normalidade 
shapiro.test(dados_anova$tx_Hemo[dados_anova$Grupo==1])
shapiro.test(dados_anova$tx_Hemo[dados_anova$Grupo==2])
shapiro.test(dados_anova$tx_Hemo[dados_anova$Grupo==3])

# homogeneidade das variancias
#com library car que nao esta funcionando


#teste ANOVA propriamente dito
ANOVA <- aov(dados_anova$tx_Hemo ~ dados_anova$Grupo)
summary(ANOVA)
#conclusao - como o p-value = (Pr(>F)) = 0,00194 < 0,05 = alpha, rejeitamos h0 e aceitamos h1, logo existe pelo menos dois grupos que possuem as medias diferentes entre si

#visualizacao pelo box plot
boxplot(dados_anova$tx_Hemo ~ dados_anova$Grupo)
