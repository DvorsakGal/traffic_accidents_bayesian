library(tidyverse)
library(boot)
library(patchwork)
library(ggplot2)
library(dplyr)
library(dagitty)

df = read_delim(here::here("hw1", "data", "road_accidents.csv"), delim = ",", show_col_types = FALSE)
df
?count()
prop.table(table(df$alcohol, df$speeding), margin = 1)
# 2. Weighted by actual number of drivers (9.0% vs 29.8% speeding)
weighted_tab <- xtabs(drivers ~ alcohol + speeding, data = df)
prop.table(weighted_tab, margin = 1)
# drivers with alcohol were speeding in 29.8% of cases compared to 9% of those who didnt have alc

sum(df$killed)
df_no_belt <- filter(df, seat_belt=="no")
sum(df_no_belt$killed)
# 582 mrtvih, od tega 188 brez varnostnega pasu (60/180 primerov)

sum(df$drivers)
# 389052 voznikov

max(df$drivers)
df |> arrange(desc(drivers)) |> slice(1:5)
# najpogostejse so nesrece, kjer noben ni alkoholiziran, noben ni speedal, vsi imajo pas, vse podnevi - Najbol common kombinacija za voznjo
# HIPOTEZE:
#the data cannot tell us whether alcohol increases the frequency of accidents—only how severe accidents are conditional on an accident happening. (This is actually a great point to include in your Discussion/Limitations section later!)

df_alc <- df |> filter(alcohol == "yes")
df_no_alc <- df |> filter(alcohol == "no")
sum(df_alc$killed)
sum(df_no_alc$killed)
sum(df_alc$seriously_injured)
sum(df_no_alc$seriously_injured)
sum(df_alc$drivers)
sum(df_no_alc$drivers)
# Torej 28549 voznikov je vozilo pod vplivom alkohola, od tega 252 killed (0.88%) in 789 seriously injured (2.76%)
# 360503 voznikov (12.6x več) ni bilo pod vplivom alkohola, od tega 330 killed (0.09%), 2089 seriously injured (0.68%)
# Na podlagi tega lahko sklepamo, da so nesrece pod vplivom alkohola bolj deadly kot tiste brez

df_full <- df |> mutate(ksi = killed + seriously_injured)
write_csv(df_full, here::here("hw1", "data", "df_with_ksi.csv"))



