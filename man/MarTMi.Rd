\name{Print_MM_Map}
\alias{Print_MM_Map}
\title{Convert R Markdown/Markdown file(s) to a Mindmap file.}
\usage{
Print_MM_Map(fn , output.fn = get_martmi_cfg('mm_name'), title = get_martmi_cfg('main_title'))
}
\arguments{
 \item{fn}{The Markdown file that will be processed to a Mindmap file.

 }
 \item{output.fn}{The name of the generated Mindmap file.

 }
 \item{title}{The tite of the Mindmap file.

 }
}
\description{
This function will convert one or more Markdown file(s) to a Mindmap file, and any input/output/images will be displayed in a seperate node.
}
\examples{

rmd_example_fn <- system.file('example_project','src',
 'NetworkPlotOne.Rmd', package = "MarkdownNMindmap")

Print_MM_Map(fn = rmd_example_fn, output.fn = 'Mindmap.mm',
 title = 'Mind map')
}
\details{The location of the nodes determined by the number of pound signs before each codeblock. The code in the codeblock is displayed as notes in their corresponding nodes.

}
\value{A Mindmap file in the working directory.

}
\author{Daniel Zhu

}
