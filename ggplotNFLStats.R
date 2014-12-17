install.packages("xlsx")
install.packages("gridExtra")
library(XML)

#page1
theurl1<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&d-447263-p=1&statisticCategory=RECEIVING&d-447263-s=RECEIVING_RECEPTIONS"
tables1<-readHTMLTable(theurl1)
length(tables1)

doc1=htmlParse(theurl1)
tableNodes1=getNodeSet(doc1, "//table")
tb1=readHTMLTable(tableNodes1[[1]],stringsAsFactors = FALSE)

#page2
theurl2<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=2&d-447263-s=RECEIVING_RECEPTIONS"
tables2<-readHTMLTable(theurl2)
length(tables2)

doc2=htmlParse(theurl2)
tableNodes2=getNodeSet(doc2, "//table")
tb2=readHTMLTable(tableNodes2[[1]],stringsAsFactors = FALSE)

#page3
theurl3<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=3&d-447263-s=RECEIVING_RECEPTIONS"
tables3<-readHTMLTable(theurl3)
length(tables3)

doc3=htmlParse(theurl3)
tableNodes3=getNodeSet(doc3, "//table")
tb3=readHTMLTable(tableNodes3[[1]],stringsAsFactors = FALSE)

#page4
theurl4<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=4&d-447263-s=RECEIVING_RECEPTIONS"
tables4<-readHTMLTable(theurl4)
length(tables4)

doc4=htmlParse(theurl4)
tableNodes4=getNodeSet(doc4, "//table")
tb4=readHTMLTable(tableNodes4[[1]],stringsAsFactors = FALSE)

#page5
theurl5<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=5&d-447263-s=RECEIVING_RECEPTIONS"
tables5<-readHTMLTable(theurl5)
length(tables5)

doc5=htmlParse(theurl5)
tableNodes5=getNodeSet(doc5, "//table")
tb5=readHTMLTable(tableNodes5[[1]],stringsAsFactors = FALSE)

#page6
theurl6<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=6&d-447263-s=RECEIVING_RECEPTIONS"
tables6<-readHTMLTable(theurl6)
length(tables6)

doc6=htmlParse(theurl6)
tableNodes6=getNodeSet(doc6, "//table")
tb6=readHTMLTable(tableNodes6[[1]],stringsAsFactors = FALSE)

#page7
theurl7<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=7&d-447263-s=RECEIVING_RECEPTIONS"
tables7<-readHTMLTable(theurl7)
length(tables7)

doc7=htmlParse(theurl7)
tableNodes7=getNodeSet(doc7, "//table")
tb7=readHTMLTable(tableNodes7[[1]],stringsAsFactors = FALSE)

#page8
theurl8<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=8&d-447263-s=RECEIVING_RECEPTIONS"
tables8<-readHTMLTable(theurl8)
length(tables8)

doc8=htmlParse(theurl8)
tableNodes8=getNodeSet(doc8, "//table")
tb8=readHTMLTable(tableNodes8[[1]],stringsAsFactors = FALSE)

#page9
theurl9<-"http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=REG&d-447263-n=1&d-447263-o=2&statisticCategory=RECEIVING&d-447263-p=9&d-447263-s=RECEIVING_RECEPTIONS"
tables9<-readHTMLTable(theurl9)
length(tables9)

doc9=htmlParse(theurl9)
tableNodes9=getNodeSet(doc9, "//table")
tb9=readHTMLTable(tableNodes9[[1]],stringsAsFactors = FALSE)

#combine tables
tbAll<-rbind(tb1,tb2,tb3,tb4,tb5,tb6,tb7,tb8,tb9)
dim(tbAll)
class(tbAll)

#rename the columns
names(tbAll)=c("Rk","Player","Team","Pos","Rec","Yds","Avg","Yds/G","Lng","TD","20+","40+","1st%","Fum")
tbAll

#import libraries
library(XML)
library(ggplot2)
library(gridExtra)
library(datasets)

#working graphs
qplot(Rec,Yds,data=tbAll)
qplot(Rec,Yds,data=tbAll,facets=~Avg)
qplot(Yds,Rec,data=tbAll,facets=~TD)
qplot(Rec,Yds,data=tbAll,alpha=I(0.5))
qplot(Rec,Yds,data=tbAll,colour=I("red"))
qplot(Team,Yds,data=tbAll,geom=c("point","smooth"),span=.2)
qplot(Rec,data=tbAll,geom="density",colour=Yds)
qplot(Rec,data=tbAll,geom="density", fill=TD)
ggplot(data=tbAll, aes(x=Rec, fill=Yds)) + geom_density(alpha=0.5)
qplot(Rec,TD,colour=TD,data=tbAll,main="Receptions")
grid.arrange(qplot(Rec, Yds, data=tbAll, colour=TD),qplot(Rec, Yds, data=tbAll, shape=TD), ncol=2)
p<-ggplot(tbAll,aes(Team,TD,colour=Pos))
p<-p+layer(geom="point")
p
ggplot(tbAll,aes(Pos,TD))+geom_point()


#Graphs used for the paper
qplot(Rec,data=tbAll,geom="density", fill=Yds, alpha=0.8)
qplot(Rec,TD,colour=Pos,data=tbAll,main="Receptions to Touchdowns")
p+geom_point(aes(colour=factor(Pos)))
p+geom_point(aes(colour=Pos))
p+geom_point()+facet_grid(.~Pos)
ggplot(tbAll,aes(Pos,TD))+geom_boxplot()
ggplot(tbAll,aes(Pos,TD))+geom_boxplot()+geom_line(aes(group=Pos))
ggplot(tbAll,aes(Pos,Avg))+geom_point()
ggplot(tbAll,aes(Avg,TD))+geom_point()
qplot(Avg,TD,colour=Pos,data=tbAll,main="Average Per Catch to Touchdowns")
ggplot(tbAll,aes(Pos,TD))+geom_point()
ggplot(tbAll,aes(Team,Pos))+geom_point()


#graphs that we couldn't get to work
qplot(Yds,Team,data=tbAll,geom="histogram")
qplot(Rec,Yds,geom="smooth",colour=Pos,data=tbAll,main="Receptions")
qplot(Rec,Yds/TD,data=tbAll,geom="boxplot")
qplot(Rec,Yds/TD,data=tbAll,geom="jitter",alpha=I(1/5))
ggplot(tbAll,aes(Rec,Yds,colour=TD))+geom_smooth(method="lm")+geom_smooth()
ggplot(tbAll,aes(Rec,TD,grou=TD))+geom_line()
ggplot(tbAll,aes(TD))+xlim(0,3)+stat_bin(aes(ymax=..count..),binwidth=.1,geom="area")
ggplot(tbAll,aes(Pos),xlab="Carats",main="Density Plot")+xlim(0,3)+stat_bin(aes(size=..density..),binwidth=.3,geom="point",position="identity")
ggplot(tbAll,aes(x=Rec,y=TD,weights=Yds,colour=Pos,size=Yds))+geom_point(alpha=.5,guide="none")+scale_size_area(breaks=c(0, 5, 10,58), "Width", max_size=20)
p<-ggplot(tbAll,aes(x=Rec,y=TD))
