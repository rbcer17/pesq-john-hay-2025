#Example
# Assuming 'data' is your combined dataset, 'x' is the independent variable,
# 'y' is the dependent variable, and 'group' is the grouping variable.
# The interaction term 'x:group' will test if the slope of x changes
# between the two groups.
#model <- lm(Sepal.Width ~ Sepal.Length * Species, data = iris)
#summary(model)
#shapiro.test(model$residuals)

kenya = as.data.frame(kenya_both_groups)
kenya$Grupo = as.factor(kenya$Grupo)
ancova = lm(kenya$`P S Total (g)` ~ kenya$`Altura (m)` * kenya$Grupo)
summary(ancova)
shapiro.test(ancova$residuals)
regr = lm(kenya$`P S Total (g)` ~ kenya$`Altura (m)`)
shapiro.test(regr$residuals)
plot(kenya$`P S Total (g)` ~ kenya$`Altura (m)`)
kenya$logpeso = log(kenya$`P S Total (g)`)
kenya$logalt = log(kenya$`Altura (m)`)
plot(kenya$logpeso ~ kenya$logalt)
ancovalog = lm(kenya$logpeso ~ kenya$logalt * kenya$Grupo)
summary(ancovalog)
shapiro.test(ancovalog$residuals)
# Extract residuals
residuals <- resid(ancovalog)

# Plot residuals against fitted values
plot(fitted(ancovalog), residuals,
     main = "Residual Plot",
     xlab = "Fitted Values",
     ylab = "Residuals")

# Add a horizontal line at zero
abline(h = 0, col = "red")

library(ggplot2)

# Sample data (replace with your actual data)
data <- data.frame(
  x = c(1:10, 1:10),
  y = c(1:10 + rnorm(10, 0, 1), 1:10 + rnorm(10, 2, 1)),
  group = factor(rep(c("A", "B"), each = 10))
)
#two regressions on one plot
# Method 1: Using geom_smooth with grouping
ggplot(kenya, aes(x = logalt, y = logpeso, color = Grupo)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Two Regression Lines on One Plot",
       x = "Altura",
       y = "Peso") +
  scale_color_manual(values = c("blue", "red")) # Optional: Customize colors

ggplot(kenya, aes(x = `Altura (m)`, y = `P S Total (g)`, color = Grupo)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Two Regression Lines on One Plot",
       x = "Altura",
       y = "Peso") +
  scale_color_manual(values = c("blue", "red")) # Optional: Customize color
#compare data from hay and kenya
haykenya = as.data.frame(hay_kenya_arundo_both_groups)
haykenya$coletor = as.factor(haykenya$coletor)
#plot 2 regression lines one for each collector
ggplot(haykenya, aes(x = `Altura (m)`, y = `P S Total (g)`, color = coletor)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Two Regression Lines on One Plot",
       x = "Altura",
       y = "Peso") +
  scale_color_manual(values = c("blue", "red")) # Optional: Customize color
#Testing if repeated measures show different regressions
hayrepeats = as.data.frame(hay_arundo_repeats_vs_no)
hayrepeats$Grupo = as.factor(hayrepeats$Grupo)
hayrepeats$repeats = as.factor(hayrepeats$repeats)
ggplot(hayrepeats, aes(x = `Altura Total (m)`, y = `P S Total 2 (g)`, color = repeats)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Two Regression Lines on One Plot",
       x = "Altura",
       y = "Peso") +
  scale_color_manual(values = c("blue", "red")) # Optional: Customize color
