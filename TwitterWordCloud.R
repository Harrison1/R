#date and time
date()
Sys.time()

#import library and set up url
library(XML)
yahooUrl="http://finance.yahoo.com/q/hp?s=AAPL"
table=readHTMLTable(yahooUrl)
class(table)

#parse doc
doc=htmlParse(yahooUrl)
tableNodes=getNodeSet(doc, "//table")

#read HTML table into an R object for easy reading
table=readHTMLTable(tableNodes[[15]], as.data.frame=TRUE, trim=TRUE, stringsAsFactors=FALSE, header=TRUE, colClasses = c("character", rep("FormattedNumber",5)), skip.rows=c(1:34, 46:67))
str(table)
class(table)
print(table[c("Date", "Close")], right=FALSE, row.names=TRUE)

#import twitter library
library(twitteR)

#set up twitter api
reqURL = "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"
consumerKey = "r0zFOLDE87mEg09ROfMGQEAGj"
consumerSecret = "5HyDXKW4emrL20flD4fiMrzk7HHffvTACfNfmeaGr4ekhkcrkD"

#twit creditials authoriziation
twitCred <- OAuthFactory$new(consumerKey=consumerKey, consumerSecret=consumerSecret, requestURL=reqURL, accessURL=accessURL, authURL=authURL)

#Do I have to run this everytime i open the program?
twitCred$handshake()

#Register twitCred
registerTwitterOAuth(twitCred)

#search Twitter and run what is found. Dates are not working, mainly until will break the code
ST=searchTwitter("iPhone Apple", n=100, lang='en', since=NULL, until=NULL, locale=NULL, geocode=NULL, sinceID=NULL, retryOnRateLimit=120)
ST

#install and grab tm and wordcload packages
install.packages("tm")
library(tm)
install.packages("wordcloud")
library(wordcloud)

#search twitter for what I believe is a vector of words
#Phlly 39.9522, -75.164
#Miami geocode='25.7739, -80.194, 10mi'
date()
Sys.time()
r_stats<- searchTwitter("alibaba", n=100, lang="en", since='2014-11-11')
r_stats2<-sapply(r_stats,function(x) x$getText())

#standard run for wordcloud graphic
WSC<-Corpus(VectorSource(r_stats2))
WSC<-tm_map(WSC,removePunctuation)
WSC<-tm_map(WSC,removeNumbers)
WSC<-tm_map(WSC,removeWords,stopwords("en"))

#run wordcloud. This works
wordcloud(WSC)

#carolin
r_stats<- searchTwitter("panthers nfl football", n=100, lang="en")
r_stats2<-sapply(r_stats,function(x) x$getText())

#standard run for wordcloud graphic
WSC<-Corpus(VectorSource(r_stats2))
WSC<-tm_map(WSC,removePunctuation)
WSC<-tm_map(WSC,removeNumbers)
WSC<-tm_map(WSC,removeWords,stopwords("en"))

#run wordcloud. This works
wordcloud(WSC)

#the same process as above but it does not work
r_stats<- searchTwitter("philly eagles football", n=100, lang="en")
r_stats2<-sapply(r_stats,function(x) x$getText())

r_stats

WSC<-Corpus(VectorSource(r_stats2))
WSC<-tm_map(WSC,removePunctuation)
WSC<-tm_map(WSC,removeNumbers)
WSC<-tm_map(WSC,removeWords,stopwords("en"))

wordcloud(WSC)

r_stats<- searchTwitter("apple iphone 6 launch", n=500, lang="en", since='2014-09-09')
r_stats2<-sapply(r_stats,function(x) x$getText())

WSC<-Corpus(VectorSource(r_stats2))
WSC<-tm_map(WSC,removePunctuation)
#WSC<-tm_map(WSC,removeNumbers)
WSC<-tm_map(WSC,removeWords,stopwords("en"))

wordcloud(WSC)

r_stats<- searchTwitter("apple iphone 6 launch", n=500, lang="en", since='2014-09-19')
r_stats2<-sapply(r_stats,function(x) x$getText())

WSC<-Corpus(VectorSource(r_stats2))
WSC<-tm_map(WSC,removePunctuation)
#WSC<-tm_map(WSC,removeNumbers)
WSC<-tm_map(WSC,removeWords,stopwords("en"))

wordcloud(WSC)


