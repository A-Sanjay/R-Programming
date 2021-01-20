library(dplyr)
sample(murders,3)
#1.Taking sample from the data of size 5
sample_murder=sample_n(murders,5) 
sample_murder

#2.Taking sample of fraction about 10% frm the data 
sample_frac<-sample_frac(murders,0.1)
View(sample_frac)

#3.Selecting the data
select_murder<-select(sample_murder,state,population)
View(select_murder)

#4.selecting variable starting with a letter
letterstart = select(sample_murder, starts_with("p"))
View(letterstart)
letterremove = select(sample_murder, -starts_with("p"))
View(letterremove)

#5.Renaming a variable
rename(sample_murder, people=population)
 
# 6.Filtering a data that as murder greater than 100:
#filtermurder<-filter(sample_murder,state=='Colorado')
#View(filtermurder)
filtermurder2<-filter(sample_murder,total>100)
View(filtermurder2)
filter3 = filter(murders, state%in% c("Colorado", "Texas"))
filter3

#7.summarize
summary<-summarise(murders, total_mean = mean(population))
View(summary)

#8.Arrange
arrange<-arrange(sample_murder,total,population)
View(arrange)
filter3%>%arrange(total,population)
 
#9.group_by 
group_by(murders, south)
 
#10. Slice:
slice(murders,0:3)

#11.Mutatate
mutat<-mutate(murders,new=population/total)
View(mutat)

#12. Intersect:  
murders$region <- rownames(murders)
first <- murders[1:20, ]
second <- murders[10:32, ]
intersect(first,second)

#13.Multiply a variables by 1000:
multiplemurder =mutate_all(letterstart, funs("new_population" = .* 1000))
View(multiplemurder)

#14.
rankmurder= mutate_at(murders, vars(Y2008:Y2010), funs(Rank=min_rank(.))) 

