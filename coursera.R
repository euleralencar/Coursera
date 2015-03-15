
#Command line interface CLI

data <- read.csv("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\getdata-data-ss06hid.csv")
names(data)
mean(data$ADJUST, rm.na=T)
length(which(data$ADJUST >= 1000000))

data$FES

data <- read.xls("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\getdata-data-DATA.gov_NGAP.xlsx")

#Coletando os dados na internet

if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/dz54-2aru/rows.xlsx?acessType=DOWNLOAD"
download.file(fileUrl,destfile="C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\cameras.xlsx",method="curl")
dateDownload <- date()

# Acessando no R
install.packages("xlsx")
library(xlsx)
cameraData <- read.xlsx("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\cameras.xlsx". sheetIndex=1,header=T)
head(cameraData)

#Some Tips - How to get a peace of information
colIndex <- 2:3
colIndex <- 1:4
cameraDataSubset <- read.xlsx("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\cameras.xlsx", sheetIndex=1, colIndex=colIndez, rowIndex=rowIndex)

cameraDataSubset

# write.xlsx -> writeout a information in excel
# read.xlsx2 -> can use, but isnt good to subsets
# package -> XLConnect
# tutorial -> XLConnect vignette 
# advice -> use .csv or .tab/.txt

#________________________________________
# Quiz 1 - Cleaning data
#________________________________________


#Questão 1 - variável de interesse VAL
a = length(which(data$VAL>13))
b = length(which(data$VAL>23))
b
c = length(which(data$VAL==24))
c
a-b

#length(which(data$ADJUST >= 1000000))
subdata <- subset(data, VAL>13, VAL)
length(which(!is.na(subdata$VAL)))

# length(which(a == "Kat")) 
# lengthwhichis.na(a)))
# length(which(a != "Kat")) 
# length(which(!is.na(a)))
# length(which(a != "NA")) 
# length(which(a == "NA")) 

#Questão 3 - Ok

install.packages("xlsx")
#Sys.setenv(JAVA_HOME='C:\Program Files\Java\jre7') # for 64-bit version
#Sys.setenv(JAVA_HOME="C:\\Program Files (x86)\\Java\\jre6") # for 32-bit version
#library(rJava)
library(xlsx)

#install.packages("XLConnect")
#library(XLConnect)

numCol <- 7:15
numLin <- 18:23
dat <- read.xlsx("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\getdata-data-DATA.gov_NGAP.xlsx", sheetIndex = 1, colIndex=numCol, rowIndex=numLin)

View(dat)

sum(dat$Zip*dat$Ext, na.rm=T)

# Questão 4 - XML

install.packages("XML")
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)


# Questão 5

DT <- read.csv("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\getdata-data-ss06pid.csv", header=T)
install.packages("data.table")
library(data.table)

# Other command to up a date
#DT1 <- fread("C:\\Users\\t318769.TRIBUNAL\\Desktop\\Coursera\\getdata-data-ss06pid.csv", header=T)

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15,DT$SEX,mean)
sapply(split(DT$pwgtp15,DT$SEX),mean)



