source('ConfigureR.R')
source("RevisingMindrinR.R")

source('src/Mindmap2Markdown.R')
fn <- 'src/NetworkPlotOne.rmd'
final <- Print_MM_Map(fn)
#prj_fn <- dirname(normalizePath(fn))
#normalizePath(prj_fn, "../graphs")

#output to Test2.mm
#final <- PrintMap(rmd_info = rmd_parser(fn), o = 'Test2.mm')
fdn <- 'src/Example2.rmd'
Final <- Print_MM_Map(fdn, o = 'Test3.mm')

multi_fn <- 'src'
FINAL <- Print_MM_Map(multi_fn, o='Test4.mm')

mind2mark1 <- PrintRMDFile( 'Test2.mm', o='mm_output.rmd')
mind2mark2 <- PrintRMDFile('Test3.mm', o='mm_output2.rmd')
mind2mark3 <- PrintRMDFile('Test4.mm', o='mm_output3.rmd')

#/Users/Daniel_Zhu_Account/Documents/summer2018/R_code/Test_Inputs/Input2

# x <- rmd_parser(fdn)
# str <- PrintMap(x)
