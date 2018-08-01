<map version ="1.0.1">
<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
Mind map
">


<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
NetworkPlotOne.Rmd
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
# Init
">
<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>
```{r setup, include=F, results='hide', message=F, warning=F}
knitr::opts_knit$set(root.dir = normalizePath(".."))


comm.libs &lt;- c("plyr", "tidyverse", "stringr", "ggplot2", "openxlsx")
.tmp &lt;- lapply(comm.libs, require, character.only = TRUE)

set.seed(17)
default.par &lt;- par(no.readonly = TRUE)
options(stringsAsFactors = FALSE)

#ggplot theme set
theme_set(theme_bw())
fontsize = 18L
theme_update(axis.title.x = element_text(size=fontsize))
theme_update(axis.title.y = element_text(size=fontsize))
theme_update(plot.title = element_text(size=fontsize+2))
```
</pre>
  </body>
  </html>
  </richcontent>


</node>
<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
#First Generation of Random Network
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
## Using matrix
">
<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>
```{r}
# Library
library(igraph)
 
# Create data
set.seed(1)
data=matrix(sample(0:1, 100, replace=TRUE, prob=c(0.8,0.2)), nc=10)
network=graph_from_adjacency_matrix(data , mode='undirected', diag=F )
 
# Default network
par(mar=c(0,0,0,0))
plot(network)

dev.copy2pdf(file="graphs/network1.pdf", width=6, height=4)
```
</pre>
  </body>
  </html>
  </richcontent>

<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: dev.copy2pdf(file=&quot;graphs/network1.pdf&quot;, width=6, height=4)
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
!!!
">

<richcontent TYPE="NODE"><html>
  <head>
  </head>
  <body>
  <p><img src="
/Users/Daniel_Zhu_Account/Library/R/3.3/library/MarkdownNMindmap/example_project/graphs/.images/network1.png
"/>
  </p>
  </body>
  </html>
  </richcontent>
  
</node>
</node>
</node>
</node>
<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
# Modify Vertex
">
<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>
```{r}
set.seed(1)

pdf(file="graphs/network2.pdf", width=6,height=4)
plot(network,
    vertex.color = rgb(0.8,0.2,0.6,0.9),           # Node color
    vertex.frame.color = "Yellow",            # Node border color
    vertex.shape=c("circle","square"),             # One of “none”, “circle”, “square”, “csquare”, “rectangle” “crectangle”, “vrectangle”, “pie”, “raster”, or “sphere”
    vertex.size=c(15:24),                          # Size of the node (default is 15)
    vertex.size2=NA                               # The second size of the node (e.g. for a rectangle)
    )
dev.off()
 
```
</pre>
  </body>
  </html>
  </richcontent>

<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: pdf(file=&quot;graphs/network2.pdf&quot;, width=6,height=4)
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
!!!
">

<richcontent TYPE="NODE"><html>
  <head>
  </head>
  <body>
  <p><img src="
/Users/Daniel_Zhu_Account/Library/R/3.3/library/MarkdownNMindmap/example_project/graphs/.images/network2.png
"/>
  </p>
  </body>
  </html>
  </richcontent>
  
</node>
</node>
</node>
<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
# Modify Edges
">
<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>
```{r}
plot(network,
    edge.color=rep(c("red","pink"),5),           # Edge color
    edge.width=seq(1,10),                        # Edge width, defaults to 1
    edge.arrow.size=1,                           # Arrow size, defaults to 1
    edge.arrow.width=1,                          # Arrow width, defaults to 1
    #edge.lty=c(1,2),                            # Line type, could be 0 or “blank”, 1 or “solid”, 2 or “dashed”, 3 or “dotted”, 4 or “dotdash”, 5 or “longdash”, 6 or “twodash”
    edge.curved=rep(c(T,F), each=20)            # Edge curvature, range 0-1 (FALSE sets it to 0, TRUE to 0.5)
    )
dev.copy2pdf(file="graphs/network3.pdf", width=6, height=4)
```
</pre>
  </body>
  </html>
  </richcontent>

<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: dev.copy2pdf(file=&quot;graphs/network3.pdf&quot;, width=6, height=4)
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
!!!
">

<richcontent TYPE="NODE"><html>
  <head>
  </head>
  <body>
  <p><img src="
/Users/Daniel_Zhu_Account/Library/R/3.3/library/MarkdownNMindmap/example_project/graphs/.images/network3.png
"/>
  </p>
  </body>
  </html>
  </richcontent>
  
</node>
</node>
</node>
<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
# Data from external source
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
## Ex. Website
">
<richcontent TYPE="NOTE"><html>
  <head>
  </head>
  <body>
  <pre>
```{r}
.d &lt;-read.csv(file='http://jfaganuk.github.io/assets/Camp92.txt')

.d2 &lt;- subset(.d, !duplicated(Node))
row.names(.d2) &lt;- .d2$Node
.d3 &lt;- .d2[,-1]
Camp92.dat &lt;- as.matrix(.d3)


SocialNetwork=graph_from_adjacency_matrix(Camp92.dat , mode='undirected', weighted=T )
plot(SocialNetwork)
dev.copy2pdf(file="graphs/SocialNetwork.pdf", width=6, height=4)

camp.dat2 &lt;- Camp92.dat &lt; 10
SocialNetwork2=graph_from_adjacency_matrix(camp.dat2 , mode='undirected')
op &lt;- par(mfrow=c(1,2))
plot(SocialNetwork)
plot(SocialNetwork2)
par(op)
dev.copy2pdf(file="graphs/SocialNetworkBoth.pdf", width=6, height=4)

ProjectTemplate::cache("camp.dat2")
```
</pre>
  </body>
  </html>
  </richcontent>
<node BACKGROUND_COLOR="#00cccc" COLOR="#000000" STYLE="bubble" TEXT="
IN: .d &lt;-read.csv(file=&apos;http://jfaganuk.github.io/assets/Camp92.txt&apos;)
">

</node>
<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: dev.copy2pdf(file=&quot;graphs/SocialNetwork.pdf&quot;, width=6, height=4)
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
!!!
">

<richcontent TYPE="NODE"><html>
  <head>
  </head>
  <body>
  <p><img src="
/Users/Daniel_Zhu_Account/Library/R/3.3/library/MarkdownNMindmap/example_project/graphs/.images/SocialNetwork.png
"/>
  </p>
  </body>
  </html>
  </richcontent>
  
</node>
</node>
<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: dev.copy2pdf(file=&quot;graphs/SocialNetworkBoth.pdf&quot;, width=6, height=4)
">

<node BACKGROUND_COLOR="#ffffff" COLOR="#000000" STYLE="bubble" TEXT="
!!!
">

<richcontent TYPE="NODE"><html>
  <head>
  </head>
  <body>
  <p><img src="
/Users/Daniel_Zhu_Account/Library/R/3.3/library/MarkdownNMindmap/example_project/graphs/.images/SocialNetworkBoth.png
"/>
  </p>
  </body>
  </html>
  </richcontent>
  
</node>
</node>
<node BACKGROUND_COLOR="#99ff99" COLOR="#0000ff" STYLE="bubble" TEXT="
OUT: ProjectTemplate::cache(&quot;camp.dat2&quot;)
">


</node>
</node>
</node>
</node>
</node>
</map>


