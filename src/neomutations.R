## -*- R -*-

# calcul du score de qualité moyen aux néomutations

library(gcbiasr)
library(dplyr)
library(ggplot2)

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
