## -*- R -*-

## calcul du score de qualité moyen aux restaurations de l'haplotype sauvage.

library(gcbiasr)
library(dplyr)
library(ggplot2)

#' pas normal la distirbutino
shapiro.test(sample(conversion_tract$qual, 1000))

set_gcbiasr_theme()

simulated_data = replicate(expr =
              conversion_tract %>%
              mutate(isrestor = ifelse(is.na(isrestor), FALSE, TRUE)) %>%
              keep_clean_only() %>%
              filter(cons == "x" | cons == "X") %>%
              group_by(isrestor) %>%
              sample_n(., 20, replace = FALSE) %>%
              kruskal.test(data = ., qual ~ isrestor) %>%
              broom::tidy(),
          n = 100, simplify = FALSE
          )

# extraction de la p.value du test
lapply(simulated_data, function(i) i$p.value) %>%
    unlist() %>%
    as.data.frame() %>%
    mutate(signif = ifelse(. > 0.05, TRUE, FALSE)) %>%
    summarise(100 - sum(signif))

    qplot(data = ., .) +
    geom_vline(xintercept = 0.05)

conversion_tract %>%
    keep_clean_only() %>%
    filter(cons == "x" | cons == "X") %>%
    group_by(isrestor) %>%
    summarise(mean = mean(qual),  count = n(), median = median(qual))

conversion_tract %>%
    keep_clean_only() %>%
    filter(cons == "x" | cons == "X") %>%
    mutate(isrestor = ifelse(is.na(isrestor), FALSE, TRUE)) %>%
    kruskal.test(data = . , qual ~ isrestor )

conversion_tract %>%
    keep_clean_only() %>%
    mutate(badqual = ifelse(qual < 30, TRUE, FALSE),
           isrestor = ifelse(is.na(isrestor), FALSE, TRUE)) %>%
    group_by(isrestor) %>%
    summarise(prop = mean(badqual), n())

ggplot(conversion_tract,
       aes(x = qual)) +
    geom_histogram() +
    facet_wrap( ~cons , scales = "free")

conversion_tract %>%
    group_by(name) %>%
    summarise(med = median(qual)) %>%
    qplot(data = ., med)


##+ Quand on enlève les sites restaurés de faible qualité, on n'a pas de
##+ différences significatives. Quand on les laisse, la différence est significative.

wilcox.test(x = conversion_tract$qual[
                conversion_tract$isrestor & conversion_tract$qual > 30
            ],
            y = conversion_tract$qual[
                is.na(conversion_tract$isrestor)
            ])

## Différence significative
wilcox.test(x = conversion_tract$qual[
                conversion_tract$isrestor #& conversion_tract$qual > 30
            ],
            y = conversion_tract$qual[
                is.na(conversion_tract$isrestor)
            ])
