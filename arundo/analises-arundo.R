#Example
# Assuming 'data' is your combined dataset, 'x' is the independent variable,
# 'y' is the dependent variable, and 'group' is the grouping variable.
# The interaction term 'x:group' will test if the slope of x changes
# between the two groups.
#model <- lm(Sepal.Width ~ Sepal.Length * Species, data = iris)
#summary(model)
#shapiro.test(model$residuals)

