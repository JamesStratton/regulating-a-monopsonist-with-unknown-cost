This GitHub contains code for ["Regulating a Monopsonist With Unknown Productivity"](https://stratton.scholars.harvard.edu/sites/g/files/omnuum10751/files/2026-05/Regulating%20a%20Monopsonist%20with%20Unknown%20Productivity.pdf).
The code is in three parts. 
First, `code/create diagrams.do` generates Figures 1, 2, and 3, which do not involve any data. 
Second, `code/download data.do` downloads the data for Appendix Figure A2. 
Third, `code/create wage histogram.do` creates Appendix Figure A2. 
The data are accessed through IPUMS USA. 
Downloading the data requires [requesting an IPUMS API key](https://developer.ipums.org/docs/v2/get-started/), and entering that API key into `code/download data.do`. 

IPUMS data are generously made available by Sarah Flood, Miriam King, Renae Rodgers, Steven Ruggles, J. Robert Warren, Daniel Backman, Etienne Breton, Grace Cooper, Julia A. Rivera Drew, Stephanie Richards, David Van Riper. Integrated Public Use Microdata Series, Current Population Survey: Version 13.0 [dataset]. Minneapolis, MN: IPUMS, 2025. 
