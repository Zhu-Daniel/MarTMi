library(XML)
library(RCurl)
url <- "https://www.google.com/search?biw=1420&bih=865&ei=CcAvW763NanU5gLauYO4Cw&q=%22daniel+zhu%22+richard+montgomery&oq=%22daniel+zhu%22+richard+montgomery&num=1000"
char.vec <- readLines(url, warn = FALSE)

doc <- getURL("https://www.google.com/search?biw=1420&bih=865&ei=CcAvW763NanU5gLauYO4Cw&q=%22daniel+zhu%22+richard+montgomery&oq=%22daniel+zhu%22+richard+montgomery&num=1000", httpheader = c("User-Agent" = "R (2.10.0)"))

html <- htmlTreeParse(doc, useInternalNodes = TRUE, error=function(...){})

zz = htmlParse(doc, asText=TRUE)
Desc.text <- xpathSApply(zz, "//h3", xmlValue)

desc.text <- xpathSApply(zz, "//span[@class='st']", xmlValue) 
cite.text <- xpathSApply(zz, "//cite", xmlValue) 
title.text <- xpathSApply(zz, "//h3[@class='r']", xmlValue) 

# cat(paste(plain.text, collapse = "\n"))


txt <- htmlToText(html)
#doc.text = unlist(xpathApply(html, '//li', xmlValue))

#src = xpathApply(html, "//a[@href]", xmlGetAttr, "href")

# Author: Tony Breyal
# Date: 2011-11-18
# Modified: 2011-11-18
# Description: Extracts all text from a webpage (aims to extract only the text you would see in a web browser)
# Packages Used: RCurl, XML   
# Blog Reference: Not published

# Copyright (c) 2011, under the Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0) License
# For more information see: https://creativecommons.org/licenses/by-nc/3.0/
# All rights reserved.

htmlToText <- function(input, ...) {
  ###---PACKAGES ---###
  require(RCurl)
  require(XML)
  
  
  ###--- LOCAL FUNCTIONS ---###
  # Determine how to grab html for a single input element
  evaluate_input <- function(input) {    
    # if input is a .html file
    if(file.exists(input)) {
      char.vec <- readLines(input, warn = FALSE)
      return(paste(char.vec, collapse = ""))
    }
    
    # if input is html text
    if(grepl("</html>", input, fixed = TRUE)) return(input)
    
    # if input is a URL, probably should use a regex here instead?
    if(!grepl(" ", input)) {
      # downolad SSL certificate in case of https problem
      if(!file.exists("cacert.perm")) download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.perm")
      return(getURL(input, followlocation = TRUE, cainfo = "cacert.perm"))
    }
    
    # return NULL if none of the conditions above apply
    return(NULL)
  }
  
  # convert HTML to plain text
  convert_html_to_text <- function(html) {
    doc <- htmlParse(html, asText = TRUE)
    text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
    return(text)
  }
  
  # format text vector into one character string
  collapse_text <- function(txt) {
    return(paste(txt, collapse = " "))
  }
  
  ###--- MAIN ---###
  # STEP 1: Evaluate input
  html.list <- lapply(input, evaluate_input)
  
  # STEP 2: Extract text from HTML
  text.list <- lapply(html.list, convert_html_to_text)
  
  # STEP 3: Return text
  text.vector <- sapply(text.list, collapse_text)
  return(text.vector)
}


# ###--- EXAMPLES ---###
# # Example 1: url input
# input <- "http://www.google.co.uk/search?gcx=c&sourceid=chrome&ie=UTF-8&q=r+project#pq=%22hello+%3C+world%22&hl=en&cp=5&gs_id=3r&xhr=t&q=phd+comics&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=phd+c&aq=0&aqi=g4&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=27ff09b2758eb4df&biw=1599&bih=904"
# txt <- htmlToText(input)
# txt
# 
# #r project - Google Search Web Images Videos Maps News Shopping Gmail More Translate Books Finance Scholar Blogs YouTube Calendar Photos Documents Sites Groups Reader Even more » Account Options Sign in Search settings Web History Advanced Search Results  1  -  10  of about  336,000,000  for  r project . Everything More Search Options Show options... Web The  R Project  for Statistical Computing R , also called GNU S, is a strongly functional language and environment to    statistically explore data sets, make many graphical displays of data from custom  ... www. r - project .org/  -  Cached  -  Similar [Trunc...]


txt <- htmlToText(doc)

url <- "https://www.google.com/search?biw=1420&bih=865&ei=CcAvW763NanU5gLauYO4Cw&q=%22daniel+zhu%22+richard+montgomery&oq=%22daniel+zhu%22+richard+montgomery&num=1000"
char.vec <- readLines(url, warn = FALSE)


library(RCurl)
library(XML)

get_google_page_urls <- function(u) {
  # read in page contents
  html <- getURL(u)
  
  # parse HTML into tree structure
  doc <- htmlParse(html)
  
  # extract url nodes using XPath. Originally I had used "//a[@href][@class='l']" until the google code change.
  attrs <- xpathApply(doc, "//h3//a[@href]", xmlAttrs)
  
  # extract urls
  links <- sapply(attrs, function(x) x[[1]])
  
  # free doc from memory
  free(doc)
  
  # ensure urls start with "http" to avoid google references to the search page
  links <- grep("http://", links, fixed = TRUE, value=TRUE)
  return(links)
}

u <- "http://www.google.co.uk/search?aq=f&gcx=w&sourceid=chrome&ie=UTF-8&q=r+project"
get_google_page_urls(u)



#Create XML file from text
data <-
  read.csv(textConnection('"date","UYG.Open","UYG.High","UYG.Low","UYG.Close","UYG.Volume","UYG.Adjusted"
                          "2007-02-01",71.32,71.34,71.32,71.34,200,69.23
                          "2007-02-02",72.2,72.2,72.2,72.2,200,70.06
                          "2007-02-05",71.76,71.76,71.76,71.76,5100,69.63
                          "2007-02-06",72.85,72.85,72.85,72.85,3800,70.69
                          "2007-02-07",72.85,72.85,72.85,72.85,0,70.69'),
           as.is=TRUE)

library(XML)

xml <- xmlTree()
xml$addTag("document", close=FALSE)
for (i in 1:nrow(data)) {
  xml$addTag("row", close=FALSE)
  for (j in names(data)) {
    xml$addTag(j, data[i, j])
  }
  xml$closeTag()
}
xml$closeTag()

# view the result
cat(saveXML(xml))

##################################

z = xmlTree("people", namespaces = list(r = "http://www.r-project.org"))
z$setNamespace("r")

z$addNode("person", attrs = c(id = "123"), close = FALSE)
z$addNode("firstname", "Duncan")
z$addNode("surname", "Temple Lang")
z$addNode("title", "Associate Professor")
z$addNode("expertize", close = FALSE)
z$addNode("topic", "Data Technologies")
z$addNode("topic", "Programming Language Design")
z$addNode("topic", "Parallel Computing")
z$addNode("topic", "Data Visualization")
z$addNode("topic", "Meta-Computing")
z$addNode("topic", "Inter-system interfaces")
z$closeTag()
z$addNode("address", "4210 Mathematical Sciences Building, UC Davis")
z$closeTag()

tr <- xmlTree("CDataTest")
tr$addTag("top", close=FALSE)
tr$addCData("x <- list(1, a='&');\nx[[2]]")
tr$addPI("S", "plot(1:10)")
tr$closeTag()
cat(saveXML(tr$value()))


f = tempfile()
saveXML(tr, f, encoding = "UTF-8")


# Creating a node
x = rnorm(3)
z = xmlTree("r:data", namespaces = c(r = "http://www.r-project.org"))
z$addNode("numeric", attrs = c("r:length" = length(x)))


# shows namespace prefix on an attribute, and different from the one on the node.
z = xmlTree()
z$addNode("r:data",  namespace = c(r = "http://www.r-project.org",
                                   omg = "http://www.omegahat.net"),
          close = FALSE)
x = rnorm(3)
z$addNode("r:numeric", attrs = c("omg:length" = length(x)))


z = xmlTree("examples")
z$addNode("example", namespace = list(r = "http://www.r-project.org"), close = FALSE)
z$addNode("code", "mean(rnorm(100))", namespace = "r")


x = summary(rnorm(1000))
d = xmlTree()
d$addNode("table", close = FALSE)

d$addNode("tr", .children = sapply(names(x), function(x) d$addNode("th", x)))
d$addNode("tr", .children = sapply(x, function(x) d$addNode("td", format(x))))

d$closeNode()
cat(saveXML(d))

# Dealing with DTDs and system and public identifiers for DTDs.
# Just doctype
za = xmlTree("people", dtd = "people")
# no public element
zb = xmlTree("people",
             dtd = c("people", "", "http://www.omegahat.net/XML/types.dtd"))
# public and system
zc = xmlTree("people",
             dtd = c("people", "//a//b//c//d",
                     "http://www.omegahat.net/XML/types.dtd"))



x = rnorm(3)
# <map version="1.0.1">
# <!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
# <node CREATED="1505613773743" ID="ID_336871103" MODIFIED="1508703417109" TEXT="ITMI Projects">
# <node CREATED="1505613876519" ID="ID_676774613" MODIFIED="1505613900031" POSITION="right" TEXT="Robert Lipsky">
# <node CREATED="1505614075057" ID="ID_675412101" MODIFIED="1505614602506" TEXT="Robert Dobbins; Waiting for the agreement"/>
# <node CREATED="1505614101535" FOLDED="true" ID="ID_755953687" LINK="Lipsky/Nasser_2016_J%20Clin%20Psychopharmacol_RBP-7000%20db%20study.pdf" MODIFIED="1507770251728" TEXT="Nasser 2016; pdf to read">
# <icon BUILTIN="flag-yellow"/>
# <node CREATED="1507770080052" ID="ID_1123928940" MODIFIED="1507770080052" TEXT=""/>
# </node>
# </node>
# <node CREATED="1505613814285" ID="ID_1290528765" MODIFIED="1505613908281" POSITION="right" TEXT="Palak Shal">
# <node CREATED="1505613868548" ID="ID_1414289765" LINK="../ITMI/107/miRNA_grant/Grant%20Draft%2008-27-2017_page1.zhuw.docx" MODIFIED="1507814979893" TEXT="Sample size calculation">
# <icon BUILTIN="button_ok"/>
# <node CREATED="1505763594944" ID="ID_1480590326" MODIFIED="1505763606310" TEXT="Table 2 is not feasible">
# <node CREATED="1505763606310" ID="ID_857669415" MODIFIED="1505763635518" TEXT="Patients/events might be overesitmated"/>
# <node CREATED="1505763638599" ID="ID_443045405" MODIFIED="1505763657906" TEXT="take too long time">
# <node CREATED="1505763657907" ID="ID_609376906" MODIFIED="1505763661886" TEXT="use more sites"/>
# <node CREATED="1505763663447" ID="ID_1591934986" MODIFIED="1505763672485" TEXT="archived samples"/>
# <node CREATED="1505763674322" ID="ID_648044554" MODIFIED="1505763732662" TEXT="at the trade off accuracy"/>
# </node>
# </node>
# </node>
# <node CREATED="1505613872022" ID="ID_738359645" MODIFIED="1505614919349" TEXT="107 RNAseq">
# <icon BUILTIN="flag-yellow"/>
# </node>
# <node CREATED="1505614040107" ID="ID_415971797" MODIFIED="1508521928044" TEXT="Utah RNAseq">
# <richcontent TYPE="NOTE"><html>
#   <head>
#     
#   </head>
#   <body>
#     <p>
#       Utah group is focusing on the comparison between heart failure=&gt; improve
#     </p >
#     <p>
#       Palak is looking for heart failure and normal
#     </p >
#   </body>
# </html></richcontent>
# <node CREATED="1506947865831" ID="ID_565245295" LINK="../ITMI/107/RNA-seq/Baseline%20Clinical%20data.xlsx" MODIFIED="1506947894257" TEXT="sample sheet"/>
# </node>
# <node CREATED="1505614047099" ID="ID_385225199" MODIFIED="1507815072294" TEXT="107 other data (redshift query)">
# <richcontent TYPE="NOTE"><html>
#   <head>
#     
#   </head>
#   <body>
#     <p>
#       Pending at Aaron (https://itmi.inova.org/jira/browse/DMA-42)
#     </p >
#   </body>
# </html></richcontent>
# </node>
# </node>
z = xmlTree("r:data", namespaces = c(r = "http://www.r-project.org"))
z$addNode("numeric", attrs = c("r:length" = length(x)))
mit <- z$addNode("Node", attrs=c("TEXT"="mito"))
mit$addNode("Node", attrs=c("TEXT"="sub1"))