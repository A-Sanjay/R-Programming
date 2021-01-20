install.packages('tidyr')
library(tidyr)
n = 10 
#1. creating a data frame 
tidy_dataframe = data.frame( 
  ID = c(1:n),  
  Group.1 = c(23, 345, 76, 212, 88,199, 72, 35, 90, 265), 
  Group.2 = c(117, 89, 66, 334, 90,  101, 178, 233, 45, 200), 
  Group.3 = c(29, 101, 239, 289, 176, 320, 89, 109, 199, 56)) 

# print the elements of the data frame 
tidy_dataframe 

#2.gather() reshaping wide to long format:
long <- tidy_dataframe %>%  
  gather(Group, Frequency, 
         Group.1:Group.3) 
long

#3.separate() splitting a single variable into two
separate_data <- long %>%  
  separate(Group, c("Allotment",  
                    "Number")) 
separate_data

#4.unite() merging two variables:
unite_data <- separate_data %>% 
  unite(Group, Allotment,  
        Number, sep = ".") 
unite_data

#5.spread() reshapping long to wide format:
back_to_wide <- unite_data %>%  
  spread(Group, Frequency) 
back_to_wide

#6.nest()
df <- tidy_dataframe 
df %>% nest(data = c(Group.1))

#7.Unnest()
df %>% unnest(Group.1)

#7.Unnest()
#df <- iris 
#names(iris) 
#head(df %>% nest(data = c(Species)))
#head(df %>% unnest(Species))

#8.fill()
filldata <- data.frame(Month = 1:6, Year = c(2000, rep(NA, 5))) 
filldata

# use fill() to fill missing values in  year column
filldata %>% fill(Year)

#9.drop_na()
newdata<-data.frame(Day=1:7,Year=c(20,21,rep(NA,5)))
newdata
newdata %>% drop_na(Year)

#10.replace_na()
redata<-data.frame(Day=1:7,Year=c(20,21,rep(NA,5)))
redata
redata %>% replace_na(list(Year='22'))

