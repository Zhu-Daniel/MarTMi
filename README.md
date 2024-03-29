# MarTMi <img src="images/MarTMi_logo.png" align ="right" width='200' height='200'/>

## Introduction

R coding can be a very tiring task, with many different programs and projects to keep track of throughout a career. As a result, revisiting old projects can become a tedious task that can involve hours of shifting through old programs just to understand what the programs do. The MarTMi package provides two functions that can assist with this problem, as they help convert R Markdown/Markdown (.rmd/.md) files into FreeMind/Mindmap (.mm) files and vise versa. If you are not familiar with FreeMind, check out the [wiki page](http://freemind.sourceforge.net/wiki/index.php/Main_Page). You can download FreeMind at [this site](https://sourceforge.net/projects/freemind/). The options are not limited to FreeMind, as there are many different mindmap software out there

The inspiration for MarTMi comes from [mindr](https://github.com/pzhaonet/mindr), which serves a similar purpose to what MarTMi does. MarTMi serves to improve upon mindr by adding the ability to read and convert multiple R Markdown/Markdown files to Mindmap at once, the ability to seperately display inputs, outputs, and graphs in the Mindmap files, and the ability to edit the title and the regex patterns in a seperate yaml file (.yml).

## Installation
```{r}
# Install the package from GitHub.
install.packages('devtools')
devtools::install_github('Zhu-Daniel/MarTMi')
```

## Usage

 - Print_MM_Map(fn, output.fn = get_martmi_cfg('mm_name'), title = get_martmi_cfg('main_title')) takes the desired Markdown file and creates a Mindmap version of it, with the nodes represented by the number of pound signs in the header.
 - PrintRMDFile(mm_fn, out_rmd_fn = get_martmi_cfg('rmd_name')) takes the desired Mindmap file and creates a R Markdown version of it, with the number of pound signs in the header represented by the node location.

## Examples
```{r}
library(MarTMi)
example("Print_MM_Map")
# Generates a Mindmap file with the file name 'Mindmap.mm' and the title Mindmap of some network plots. Uses the src file 'NetworkPlotOne.Rmd'
example("PrintRMDFile")
# Uses the file 'Mindmap.mm' to generate a R Markdown file with the file name 'mm_output.Rmd'.
```

Example: This is the result of example(Print_MM_Map)



 <img src="./images/MarTMi_example_output.png" />



Example 2: This graph is generated with the program on [this R-Bloggers article](http://blog.schochastics.net/post/analyzing-the-greatest-strikers-in-football-ii-visualizing-data/) by David Schoch.

<img src="./images/MarTMi_example_outputII.png" />
