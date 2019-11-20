library("tidyverse")

a <- 8

tabela <- tibble(nome = c("Julio", "Maria"), 
                 idade = c(27, 23))

tabela_facil <- tribble(~nome, ~idade, ~sobrenome,
                        "Julio", 27, "Batista",
                        "Maria", 23, "da Silva")


#importando dataframe de teste
mpg 

ggplot(mpg, aes(x = cyl, y = hwy)) +
  geom_point()

ggplot(mpg) +
  geom_point(aes(x = cyl, y = hwy))


ggplot(mpg) +
  geom_bar(aes(x = manufacturer))


ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = TRUE) +
  labs(title = "Um gráfico")


ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = manufacturer)) +
  facet_wrap(~drv)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = manufacturer)) +
  facet_grid(drv ~ year)


mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point()


summary(mpg)

mean(mpg$hwy)

sd(mpg$hwy)


idade <- c(27, 23, NA)
mean(idade, na.rm = TRUE)
sd(idade, na.rm = TRUE)


media <- function(arr){
  c <- 0
  s <- 0
  
  for(v in arr){
    if(!is.na(v)){
      c <- c + 1
      s <- s + v
    }
  }
  s / c
}

media(idade)


a <- list("0", 1, 3)
a[[3]]


pessoa <- list(
  nome=c("Julio","Maria"),
  idade=c(27,23)
)

pessoa$nome
pessoa$nome[1]


mpg %>%
  select(manufacturer, model, hwy:class)


mpg %>%
  select(manufacturer, model, displ) %>%
  filter(model == 'a4', displ > 2)



mpg %>%
  filter(model == 'a4' & displ > 2)



mpg %>%
  filter(year == 1999) %>%
  select(manufacturer, displ) %>%
  View()

mpg %>%
  filter(year == 1999) %>%
  ggplot(aes(displ, hwy)) +
  geom_point()


mpg %>%
  arrange(model, manufacturer)


mpg %>%
  filter(between(displ, 1.5, 2.5))


mpg %>%
  filter(drv %in% c('f', 'r'))


mpg %>%
  transmute(ratio = hwy / cty,
            hwy = hwy,
            cty = cty,
            ratio_2 = ratio * 2)



mpg %>%
  select(-year)

mpg %>%
  select(-(year:class))



mpg %>%
  mutate(ratio = hwy / cty)


mpg %>%
  count(manufacturer) %>%
  arrange(-n) %>%
  top_n(5)

mpg %>%
  count(manufacturer) %>%
  arrange(n) %>%
  top_n(5)


mpg %>%
  group_by(model) %>%
  summarise(hwy_mean = mean(hwy),
            cty_mean = mean(cty))


mpg %>%
  count(year) %>%
  spread(year, n) %>%
  gather('1999','2008', key = 'year', value = 'n') %>%
  View()
