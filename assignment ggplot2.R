#Do women live longer than men? How long? Does it happen everywhere? 
#Is life expectancy increasing? Everywhere? Which is the country with the lowest life expectancy? Which is the one with the highest?
#In this project, we will answer all these questions by manipulating and visualizing United Nations life expectancy data using ggplot2.

options(repr.plot.width = 6, repr.plot.height = 6)

# Loading packages
library("dplyr")
library("tidyr")
library("ggplot2")

# Loading data
life_expectancy <- read.csv("C:/Users/sanja/UNdata.csv")
View(life_expectancy)
# Taking a look at the first few rows
head(life_expectancy)

#1.Average life_expectancy of men vs women by country:
# Subsetting and reshaping the life expectancy data
subdata <- life_expectancy  %>% 
filter(Year == "2000-2005") %>%
select (Country.or.Area, Subgroup, Value) %>%
spread (Subgroup,Value)  

# Taking a look at the first few rows
head(subdata)
nrow(subdata)

#2. Visualize:
ggplot(data=subdata,aes(x=Male,y=Female)) +
geom_point()

#3.Adding reference lines:
# Adding an abline and changing the scale of axes of the previous plots
ggplot(data=subdata,aes(x=Male,y=Female)) +
geom_point()+geom_abline(intercept = 0, slope = 1,linetype = "dashed")+
xlim(35,85)+
ylim(35,85)

#4.Plot Titles and axis labels:
ggplot(subdata, aes(x=Male, y=Female))+
  geom_point(colour="white", fill="chartreuse3", shape=21, alpha=.55, size=5)+
  geom_abline(intercept = 0, slope = 1, linetype=2)+
  scale_x_continuous(limits=c(35,85))+
  scale_y_continuous(limits=c(35,85))+
  labs(title="Life Expectancy at Birth by Country",
       subtitle="Years. Period: 2000-2005. Average.",
       caption="Source: United Nations Statistics Division",
       x="Males",
       y="Females")

#5.Highlighting remarkable countries:
top_male <- subdata %>% arrange(Male-Female) %>% head(3)
top_female <- subdata %>% arrange(Female-Male) %>% head(3)

# Adding text to the previous plot to label countries of interest
ggplot(subdata, aes(x=Male, y=Female, label=Country.or.Area))+
  geom_point(colour="white", fill="chartreuse3", shape=21, alpha=.55, size=5)+
  geom_abline(intercept = 0, slope = 1, linetype=2)+
  scale_x_continuous(limits=c(35,85))+
  scale_y_continuous(limits=c(35,85))+
  labs(title="Life Expectancy at Birth by Country",
       subtitle="Years. Period: 2000-2005. Average.",
       caption="Source: United Nations Statistics Division",
       x="Males",
       y="Females")+
  geom_text(data=top_male, size=3)+
  geom_text(data=top_female, size=3)+
  theme_bw()  

#6.Histogram
ggplot(subdata, aes(Male))+
  geom_histogram()





