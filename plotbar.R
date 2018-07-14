library(dplyr)
library(ggplot2)
data<-read.csv(file.choose(),header = T)
data_set<-as.data.frame(data)

selected_data<-data_set%>%filter(prime_genre=="Games")%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num)
ggplot(selected_data,aes(x=user_rating))+geom_bar()