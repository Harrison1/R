#date and time
date()
Sys.time()

#Question 1

#import XML library. Made the url into a variable for easy use. Read all HTML tables in the url and then ran table to see what tables were embedded in the url.
library(XML)
cnnUrl="http://money.cnn.com/data/markets/dow/?order=d&page=1"
table=readHTMLTable(cnnUrl)
table
class(table)

#same as above for page 2
cnnUrl2="http://money.cnn.com/data/markets/dow/?order=d&page=2"
table2=readHTMLTable(cnnUrl2)
table2

#parsed through url and created nodes.
doc=htmlParse(cnnUrl)
tableNodes=getNodeSet(doc, "//table")

#same as above for page 2
doc2=htmlParse(cnnUrl2)
tableNodes2=getNodeSet(doc2, "//table")

#format the 5th table on the url into a readable table and convert into a data frame
table=readHTMLTable(tableNodes[[5]], as.data.frame = TRUE, header = TRUE, colClasses = c("character", "FormattedNumber", "FormattedNumber", "Percent", "FormattedNumber", "character", "Percent"), trim = TRUE, stringsAsFactors = FALSE)
table

#same as above for table 2
table2= readHTMLTable(tableNodes2[[5]], header = TRUE, trim=TRUE, colClasses=c("character", "FormattedNumber", "FormattedNumber", "Percent", "FormattedNumber", "character", "Percent"))
table2

#combine the two tables
bigTable=rbind(table, table2)
bigTable

#take the first six rows of the big table
head(bigTable)


#Question 2

#re-arrange the columns to meet the criteria. 
bigTable[c("Volume", "Company", "Price", "YTDchange")]
print(bigTable[c("Volume", "Company", "Price", "YTDchange")], right=FALSE, row.names=TRUE)

#Question 3

#identify the structures and the classes of the tables and columns
str(bigTable)
str(bigTable[c("Volume", "Company", "Price", "YTDchange")])
class(bigTable)
class(bigTable[c("Volume", "Company", "Price", "YTDchange")])

#Question 4

#I could not get the "Percent" value to work in readHTMLTable so I had to manually adust YTDchange
bigTableAdjusted=transform(bigTable, YTDchange = YTDchange/100)
bigTableAdjusted

