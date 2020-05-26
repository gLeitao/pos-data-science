df <- read.csv(file = "Dados.csv", sep = ";", header = TRUE, dec = ',')

#Questao 1 - Calcule as medidas de posicao para sa variaveis salario, instrucao, experiencia e idade.
#Apresente os calculos e faca uma interpretacao dos resultados.

summary(df$salario)
#R- O maior salario catalogado na entrevista possui o valor 300% mais alto do que 75% dos entrevistados.
summary(df$instrucao)
#R -  Em media, os entrevistados possuem cerca de 13 anos de forma??o formal.
summary(df$experiencia)
#R - 25% dos entrevistados possuem metade da experiencia media catalogada.
summary(df$idade)
#R - Maior parte dos entrevistados possuiam mais de 30 anos.


# Questao 2 - Calcule as medidas de dispersao para as variaveis salario, instrucao, experiencia e idade.

library("fBasics") 

max(df$salario) - min(df$salario)
sd(df$salario)
var(df$salario)
sd(df$salario)/mean(df$salario)
kurtosis(df$salario)
skewness(df$salario)

max(df$instrucao) - min(df$instrucao)
sd(df$instrucao)
var(df$instrucao)
sd(df$instrucao)/mean(df$instrucao)
kurtosis(df$instrucao)
skewness(df$instrucao)

max(df$experiencia) - min(df$experiencia)
sd(df$experiencia)
var(df$experiencia)
sd(df$experiencia)/mean(df$experiencia)
kurtosis(df$experiencia)
skewness(df$experiencia)

max(df$idade) - min(df$idade)
sd(df$idade)
var(df$idade)
sd(df$idade)/mean(df$idade)
kurtosis(df$idade)
skewness(df$idade)


# Responda o que segue:

# a) Com relacao ao Coeficiente de Variacao, qual e a variavel que possui a maior discrepancia em seus valores. E a com menor discrepancia?
# R - A variavel salario possui a maior discrepancia dentre as catalogadas, enquanto a variavel instrucao possui a menor discrepancia.

# b) Qual deve ser a interpretacao dada ao Coeficiente de Variacao?
# R - Quanto menor o coefciente de variacao, menor sera a dispersao dos dados

# c) Com Considerando que as medidas de assimetria e curtose qualificam a media como a de tendecia central,
# existe alguma das variaveis que possua problemas de assimetria e/ou curtose? Justifique.
# R - A variavel salario possui um skewness de 1,845964, o que caracterisa problemas de assimetria. As demais variaveis nao apresentaram problemas.

# Questao 3 - Considere uma analise que possa ser realizada sobre a variavel salario. Faca os procedimentos destacados a seguir:
# a) Calcule a media e a mediana do salario para mulher e homens separadamente. Qual a tendencia apresentada para media e mediana?

df_f <- df[df$sexo == 1, ]
mean(df_f$salario)
median(df_f$salario)

df_m <- df[df$sexo == 0, ]
mean(df_m$salario)
median(df_m$salario)

# R - Tanto para media quanto para mediana, o sexo masculino tende a possuir um salario consideralvemetne mais alto que o sexo feminino.

# b) Calcule a media e a mediana do salario para brancos e nao brancos separadamente. Qual a tendencia apresentada para media e mediana?

df_nb <- df[df$cor == 1, ]
mean(df_nb$salario)
median(df_nb$salario)

df_b <- df[df$cor == 0, ]
mean(df_b$salario)
median(df_b$salario)

# R - Tanto para media quanto para mediana, pessoas brancas tende a possuir um salario consideralvemetne mais alto que pessoas nao brancas.


# Questao 4 - Faca um grafico box-plot para as variaveis salario, instrucao, experiencia e idade, e identifique se existe outliers
# Quantas observacoes deveriam ser excluidas em cada variavel por serem provaveis outliers

outliers_salario <- boxplot(df$salario)
length(outliers_salario$out)
# R - Ha cerca de 61 obsevacoes como provaveis outliers que poderiam ser excluidas.


outliers_instrucao <- boxplot(df$instrucao)
length(outliers_instrucao$out)
# R - Ha 20 obsevacoes como provaveis outliers que poderiam ser excluidas.

outliers_experiencia <- boxplot(df$experiencia)
length(outliers_experiencia$out) 
# R - Ha 1 obsevacao como provavel outlier que poderia ser excluida.

outliers_idade <- boxplot(df$idade)
length(outliers_idade$out)
# Nao ha obsevacoes como provaveis outliers que poderiam ser excluidas.

# Questao 5 - Considerando os graficos de dispersao, construa-os conforme pedido a seguir

# a) faca um grafico que relacione salario com o tempo de instucao. Analise uma eventual tendencia de dados.
plot(df$instrucao, df$salario)
# R - O salario da pessoa tende a ser mais alto quanto maior for seu grau de instrucao.

# b) faca um grafico que relacione salario com tempo de experiencia. Analise eventual tendencia dos dados.
plot(df$experiencia, df$salario)
# R - O salario de pessoas com experiencia de pelo menos 5 anos tende a ser levemente mais alto que de pessoas com experencia inferior a 5 anos.

# c) faca um grafico que relacione salario com a idade. Analise eventual tendencia dos dados.
plot(df$idade, df$salario)
# R - Ha uma concetracao maior de pessoas entre 30 a 50 anos, que ganham acima dos 10 mil.

# d) faca um grafico que relacione salario com a idade. Analise eventual tendencia dos dados.
plot(df$instrucao, df$experiencia)
# R - Ha uma maior concetracao de pessoas que possuem mais de 10 anos de instrucao formal.

# Questao 6 - Considerando as variaveis estritamente quantitativas. Construa um histograma e identifique a variavel com melhor ajuste percebido para a distribuicao normal de probabilidade.
hist(df$salario)
ln_sal =log(df$salario)
hist(ln_sal)

hist(df$instrucao)
ln_ins = log(df$instrucao)
hist(ln_ins)

hist(df$experiencia)
ln_exp = log(df$experiencia)
hist(ln_exp)

hist(df$idade)
ln_id = log(df$idade)
hist(ln_id)


# R - Das variaveis em questao, a que melhor se ajusta para uma distribuicao normal e a variavel SALARIO

# Questao 7 - Conseudere a variavel salario segue uma distribuicao normal de probabilidade. A media e o desvio-padrao ja foram calculados. Assim, determine o que se pede.
# a) Qual a probabilidade estimada de uma pessoa ganhar mais do que o 3 quartil?
media_a <- mean(df$salario)
desv_a <- sd(df$salario)
q3_a <- quantile(df$salario, c(0.75))

1-pnorm(q3_a, mean = media_a, sd = desv_a)
# R - A probabilidade estimada de uma pessoa ganhar mais que o 3 quartil é de 33%

# b) Qual a probabilida estimada de ma pessoa ganhar menos que o 1 quartil
media_b <- mean(df$salario)
desv_b <- sd(df$salario)
q1_b <- quantile(df$salario, c(0.25))

pnorm(q1_b, mean = media_b, sd = desv_b)

# R - A probabilidade estimada de uma pessoa ganhar menos que o 1 quartil é de 24%

# c) O que e mais provavel, considerando a probabilidade estimada, a pessoa ganhar menos do que a media ou a pessoa ganhar menos que a mediana?

media_c <- mean(df$salario)
desv_c <- sd(df$salario)

pnorm(media_c, mean = media_c, sd = desv_c)

media_c_m <- mean(df$salario)
desv_c_m <- sd(df$salario)
mediana_c <- median(df$salario)

pnorm(mediana_c, mean = media_c_m, sd = desv_c_m)

# R - Tem 50% de chance de uma pessoa de ganhar menos que a media, e 38% de chance de ganhar menos que a mediana, Logo e mais provavel que a pessoa ganhe menos que a media, do que menos que a mediana.