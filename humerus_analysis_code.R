# Install packages
install.packages('Sleuth3')
install.packages('car')

# Load libraries
library('Sleuth3')
library(car)

head(ex0221)

humLen = ex0221
attach(humLen)

par(bg = "#fefefe")
boxplot(Humerus ~ Status 
        , main = "Distribution  of Male House Sparrows' Humerus"
        , ylab = "Humerous Length (in)"
        , xlab = "Status After Storm"
        , col = c("#f7d8ba", "#caf1de"))

# Hypothesis test
# ---------------
# H0: (Um - Uf) = 0
# H1: (Um - Uf) != 0


# Test of Assumptions
  # Independence: one sparrow's humerus isn't dependent on the length of another; we're fine
  # Random Sampling: same storm and all is said was "collected"; doesn't appear to be truly random
  
  # Equal Variance: while boxplot indicates some skew, Levene's test says we can assume equal variance
  leveneTest(Humerus ~ Status)
  
  # Normality: the sever left-skewed nature of 'Perished' birds means we're right on the edge; we'll assume normality 
  #            but evaluate our t-test p-value with a conservative eye
  shapiro.test(length[Status == 'Survived'])
  shapiro.test(length[Status == 'Perished'])

# T-Test
t.test(Humerus ~ Status
       , mu = 0
       , alt="two.sided"
       , conf = 0.95
       , var.eq = TRUE
       , paired = FALSE)


# Conclusion
  # We reject to fail H0 because of insufficient evidence to support our null hypothesis of 
  # male house sparrows humerus lengths being different, thus making this study an
  # inconclusive argument in favor of natural selection.

  # While our t-test p-value result is a small likelihood that we see these results
  # assuming our null hypothesis is true, we have reason to suspect our assumptions
  # aren't fully met, therefore requiring some extra skepticism towards our p-value.



