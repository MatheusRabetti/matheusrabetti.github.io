---
layout: post
title: AB testing multivariate
categories:
  - Statistics
description: Multivariate testing
tags: [ab testing]
---

Essa técnica permite que vários grupos sejam comparados a um só tempo. Essa análise parte do pressuposto que o acaso só produz pequenos desvios, sendo as grandes diferenças geradas por causas reais. 

# Anova
chocolate = data.frame(
Sabor =
c(5, 7, 3,
4, 2, 6,
5, 3, 6,
5, 6, 0,
7, 4, 0,
7, 7, 0,
6, 6, 0,
4, 6, 1,
6, 4, 0,
7, 7, 0,
2, 4, 0,
5, 7, 4,
7, 5, 0,
4, 5, 0,
6, 6, 3
),
Tipo = factor(rep(c("A", "B", "C"), 15)),
Provador = factor(rep(1:15, rep(3, 15))))
tapply(chocolate$Sabor, chocolate$Tipo, mean)
ajuste = lm(data = chocolate, Sabor ~ .)
summary(ajuste)
anova(ajuste)
a1 <- aov(data = chocolate, Sabor ~ Tipo + Provador)
posthoc <- TukeyHSD(x=a1, 'Tipo', conf.level=0.95)
plot(posthoc)

Generalização do test t usada para quando se existe dois ou mais tratamentos ou populações. É um teste paramétrico.
a ANOVA basicamente divide a variabilidade em variabilidade Entre Grupos e variabilidade Dentro de Grupos, e compara as duas. Quanto maior for a primeira comparada à segunda, maior é a evidência de que existe variabilidade entre grupos.

Os fatores categóricos podem ser fixos ou aleatórios. Normalmente, se o pesquisador controla os níveis de um fator, o fator é fixo. Por outro lado, se o pesquisador amostrou aleatoriamente os níveis de um fator a partir de uma população, o fator é aleatório.

Suponha que você tem um fator chamado "operador", e ele tem três níveis. Se você intencionalmente selecionar esses três operadores e quer que seus resultados se apliquem apenas a estes operadores, o fator é fixo. No entanto, se você extrair amostras aleatoriamente de três operadores de um maior número de operadores, e quer que seus resultados se apliquem a todos os operadores, o fator é aleatório.

## Repeated measures anova

Repeated measures design uses the same subjects with every branch of research, including the control.[1] For instance, repeated measurements are collected in a longitudinal study in which change over time is assessed. Other (non-repeated measures) studies compare the same measure under two or more different conditions. For instance, to test the effects of caffeine on cognitive function, a subject's math ability might be tested once after they consume caffeine and another time when they consume a placebo.

Sequencial of experiments offered to the user or multiple alternatives being delivered to the user.

* Limited number of participants — The repeated measure design reduces the variance of estimates of treatment-effects, allowing statistical inference to be made with fewer subjects.
* Efficiency — Repeated measure designs allow many experiments to be completed more quickly, as fewer groups need to be trained to complete an entire experiment. For example, experiments in which each condition takes only a few minutes, whereas the training to complete the tasks take as much, if not more time.
* Longitudinal analysis — Repeated measure designs allow researchers to monitor how participants change over time, both long- and short-term situations.

# Manova

library(tidyverse)

iris %>% 
    group_by(Species) %>% 
    summarise(sepal = mean(Sepal.Length),
              petal = mean(Petal.Length))

manova.overall <- manova(cbind(Sepal.Length, Petal.Length) ~ Species, data = iris)
summary(manova.overall)
# R: existe diferença entre os grupos (espécies) olhando para essas métricas

# Qual das métricas geram essa diferença?
summary.aov(manova.overall)
# R: as duas métricas contribuem pra diferença entre as espécies

# Qual melhor grupo (espécie)? Existe diferença entre a espécie versicolor e virginica?
# necessário correção para teste múltiplo - Bonferroni
iris %>% 
    filter(Species %in% c('versicolor', 'virginica')) %>% 
    manova(cbind(Sepal.Length, Petal.Length) ~ Species,
                      data = .) -> manova.pair 
summary(manova.pair)
summary.aov(manova.pair)

MANOVA is about multiple outcome variables. 2-way refers to the fact that you have two factors (groupings). You could have a 2-way MANOVA if you have two outcomes with two grouping factors. For example:

Measure 1: Beck Depression Inventory (BDI)
Measure 2: Beck Anxiety Inventory (BAI)
Grouping 1: Control vs. Medication
Grouping 2: Control vs. Psychotherapy
This would be a two outcome 2x2 MANOVA. There are four groups (Control, Control), (Medication, Control), (Control, Psychotherapy), (Medication, Psychotherapy). 


MANOVA vs LDA as machine learning vs. statistics

This seems to me now one of the exemplary cases of how different machine learning community and statistics community approach the same thing. Every textbook on machine learning covers LDA, shows nice pictures etc. but it would never even mention MANOVA. Probably because people there are more interested in LDA classification accuracy (which roughly corresponds to the effect size), and have no interest in statistical significance of group difference. On the other hand, textbooks on multivariate analysis would discuss MANOVA but rarely mention LDA.

# Fontes:

* ['Bootstrap Methods with Applications to R'](http://www.ievbras.ru/ecostat/Kiril/R/Biblio/R_eng/Chernick2011.pdf)
* ['Netflix Repeated Measures'](https://medium.com/netflix-techblog/interleaving-in-online-experiments-at-netflix-a04ee392ec55)
* ['Implementing Manova on R'](https://rpubs.com/aaronsc32/manova)
* http://compdiag.molgen.mpg.de/ngfn/docs/2003/mar/ANOVABoot_1.PDF
* ['Anova Repeated Measures on R'](https://www.gribblelab.org/stats/notes/RepeatedMeasuresANOVA.pdf)
* ['Parametric Bootsrap One-way Anova'](https://www.youtube.com/watch?v=6mU9RCeKgDU)
