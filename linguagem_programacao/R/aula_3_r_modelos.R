library("tidyverse")
library("modelr")

mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point()


model <- lm(hwy ~ displ, data=mpg)

model
predict(model, mpg)

mpg %>%
  add_predictions(model) %>%
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_point(aes(displ, pred), color='red')


mpg %>%
  add_residuals(model) %>%
  ggplot(aes(displ, resid)) +
  geom_point()


model_2 <- lm(hwy ~ displ + cyl + drv, data=mpg)
model_2
predict(model_2, mpg)

mpg %>%
  add_predictions(model_2) %>%
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_point(aes(displ, pred), color='red')


model_nao_linear <- lm(hwy ~ displ * cyl, data=mpg)
model_nao_linear

mpg %>%
  add_predictions(model_nao_linear) %>%
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_point(aes(displ, pred), color='red')

model_nao_linear_2 <- lm(hwy ~ I(displ^2), data=mpg)
model_nao_linear_2

mpg %>%
  add_predictions(model_nao_linear_2) %>%
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_point(aes(displ, pred), color='red')

model_nao_linear_3 <- lm(hwy ~ poly(displ, 3), data=mpg)
model_nao_linear_3

mpg %>%
  add_predictions(model_nao_linear_3) %>%
  ggplot() +
  geom_point(aes(displ, hwy)) +
  geom_point(aes(displ, pred), color='red')
