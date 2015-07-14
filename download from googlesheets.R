#Varias formas de importar dados
#Fonte: http://www.computerworld.com/article/2921176/business-intelligence/great-r-packages-for-data-import-wrangling-visualization.html

############# Utilizando GoogleSheets
##### NAO FUNCIONOU, POIS NÃO FOI ATUALIZADA

# Fonte: https://speakerdeck.com/jennybc/googlesheets-talk-at-user2015
install.packages("googlesheets")

library("googlesheets")

suppressPackageStartupMessages(library("dplyr"))

############################################

############### Utilizando GetUrl
############ NÃO FUNCIONOU
# Fonte: http://www.underdiverwaterman.com/getting-google-docs-data-into-r/

www <- "https://docs.google.com/spreadsheets/d/1DfXFbz0pbSBVHxS9M1VAX-m3Y7zypUhiYwhF_TKC8mg/pub?gid=0&single=true&output=csv"

#install.packages("RCurl")
#require(RCurl)
myCsv <- getURL(www, ssl.verifypeer = FALSE)
data <- read.csv(textConnection(myCsv))

head(data)

?getURL

# Em casa este método funcionou.

################################ Outro método
#Fonte: https://github.com/maxconway/gsheet

install.packages('gsheet')
library(gsheet)
gsheet2tbl('docs.google.com/spreadsheets/d/1I9mJsS5QnXF2TNNntTy-HrcdHmIF9wJ8ONYvEJTXSNo')


############# UTILIZANDO XLM ######################
####### FUNCINOU...................................


#Fonte: http://blog.revolutionanalytics.com/2014/06/reading-data-from-the-new-version-of-google-spreadsheets.html

install.packages("XML")
library(XML)
cleanGoogleTable <- function(dat, table=1, skip=0, ncols=NA, nrows=-1, header=TRUE, dropFirstCol=NA){
      if(!is.data.frame(dat)){
            dat <- dat[[table]]
      }
      if(is.na(dropFirstCol)) {
            firstCol <- na.omit(dat[[1]])
            if(all(firstCol == ".") || all(firstCol== as.character(seq_along(firstCol)))) {
                  dat <- dat[, -1]
            }
      } else if(dropFirstCol) {
            dat <- dat[, -1]
      }
      if(skip > 0){
            dat <- dat[-seq_len(skip), ]
      }
      if(nrow(dat) == 1) return(dat)
      if(nrow(dat) >= 2){
            if(all(is.na(dat[2, ]))) dat <- dat[-2, ]
      }
      if(header && nrow(dat) > 1){
            header <- as.character(dat[1, ])
            names(dat) <- header
            dat <- dat[-1, ]
      }
      # Keep only desired columns
      if(!is.na(ncols)){
            ncols <- min(ncols, ncol(dat))
            dat <- dat[, seq_len(ncols)]
      }
      # Keep only desired rows
      if(nrows > 0){
            nrows <- min(nrows, nrow(dat))
            dat <- dat[seq_len(nrows), ]
      }
      # Rename rows
      rownames(dat) <- seq_len(nrow(dat))
      dat
}


readGoogleSheet <- function(url, na.string="", header=TRUE){
      stopifnot(require(XML))
      # Suppress warnings because Google docs seems to have incomplete final line
      suppressWarnings({
            doc <- paste(readLines(url), collapse=" ")
      })
      if(nchar(doc) == 0) stop("No content found")
      htmlTable <- gsub("^.*?(<table.*</table).*$", "\\1>", doc)
      ret <- readHTMLTable(htmlTable, header=header, stringsAsFactors=FALSE, as.data.frame=TRUE)
      lapply(ret, function(x){ x[ x == na.string] <- NA; x})
}



# Publique a planilha como WebPage

gdoc <- "https://docs.google.com/spreadsheets/d/1r7uoB4Hm0aI1tW11KmLGHPBCe2HOGU4CgeV-vKMvvxY/pubhtml?gid=0&single=true"

elem <- readGoogleSheet(gdoc)
m <- cleanGoogleTable(elem, table=1)
head(m)
