library(tidyr)
library(dplyr)
library(ggplot2)
library(plotly)

valid_names <- read.csv("valid_country_codes.csv",skip=2)[1:236,]

metadata <- read.csv("metadata.csv") %>% 
        dplyr::select(Country.Code,Region)%>% 
        dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

df1 <- read.csv("fert.csv", skip=4) %>% 
        select(Country.Name,Country.Code,X1960:X2016)%>% 
        gather(year, fertility,X1960:X2016) %>% 
        dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

df2 <- read.csv("life_ex.csv",skip=4) %>% 
        select(Country.Name,Country.Code,X1960:X2016)%>% 
        gather(year, life_ex,X1960:X2016) %>% 
        dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

df3 <- read.csv("pop.csv") %>% 
        select(Country.Name,Country.Code,X1960:X2016)%>% 
        gather(year, population,X1960:X2016) %>% 
        dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

full <- dplyr::full_join(df1,df2,by=c("Country.Code","year")) %>% 
        dplyr::full_join(df3,by=c("Country.Code","year") ) %>% 
        dplyr::select(Country.Code:fertility, life_ex:population) 

full_w_cot <- dplyr::left_join(full, metadata, by="Country.Code") %>% 
        dplyr::mutate(year = as.numeric(gsub("X","", year)))
