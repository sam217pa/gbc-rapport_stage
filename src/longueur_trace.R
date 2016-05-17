library(gcbiasr)
library(dplyr)
library(ggplot2)

set_gcbiasr_theme()

conversion_tract %>%
    group_by(name, mutant) %>%
    summarise(length = max(refp) - unique(switchp)) %>%
    ungroup() ->
    length_tract

##==============================================================================
## Test de comparaison de moyennes non paramétriques.
##
## Je compare la moyenne des
## longueurs de traces de conversions, lorsque le donneur est GC ou lorsque le
## donneur est AT.
##
wilcox.test(
    (length_tract %>% filter(mutant == "w") %>% select(length))$length
   ,(length_tract %>% filter(mutant == "s") %>% select(length))$length
)


## J'ai fait la même chose pour comparer les longueurs de traces de conversion
## quand le premier donneur est w ou quand le premier donneur est strong.

wilcox.test(
    (length_tract %>% filter(mutant == "sw") %>% select(length))$length
   ,(length_tract %>% filter(mutant == "ws") %>% select(length))$length
)


## test global de l'impact du donneur sur la longueur de la région convertie.
## Non significatif.
kruskal.test(data = length_tract, length ~ mutant)
