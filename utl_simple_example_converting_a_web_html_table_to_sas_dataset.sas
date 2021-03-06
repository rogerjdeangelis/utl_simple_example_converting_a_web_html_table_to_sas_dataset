Simple example converting a web html table to sas dataset

INPUT
=====
see
https://www.fdic.gov/bank/individual/failed/banklist.html


PROCESS (WPS Proc R)
=======

%utl_submit_wps64('
libname sd1 "d:/sd1";
options set=R_HOME "C:/Program Files/R/R-3.3.1";
libname wrk sas7bdat "%sysfunc(pathname(work))";
proc r;
submit;
library(rvest);
library(dplyr);
source("C:/Program Files/R/R-3.3.1/etc/Rprofile.site", echo=T);
URL <- "https://www.fdic.gov/bank/individual/failed/banklist.html";
want <- URL %>%
  read_html() %>%
  html_table() %>%
  as.data.frame();
endsubmit;
import r=want  data=wrk.want;
run;quit;
');

OUTPUT
======

Up to 40 obs from want total obs=555

Obs  BANK_NAME                             CITY                ST   CERT  ACQUIRING_INSTITUTION       CLOSING_DATE        UPDATED_DATE

  1  Washington Federal Bank for Savings   Chicago             IL  30570  Royal Savings Bank          December 15, 2017   February 21, 2018
  2  Fayette County Bank                   Saint Elmo          IL   1802  United Fidelity Bank, fsb   May 26, 2017        July 26, 2017
  3  First NBC Bank                        New Orleans         LA  58302  Whitney Bank                April 28, 2017      December 5, 2017
  4  Proficio Bank                         Cottonwood Heights  UT  35495  Cache Valley Bank           March 3, 2017       March 7, 2018
....

550    Sinclair National Bank              Gravette            AR  34248  Delta Trust & Bank          September 7, 2001   October 6, 2017
551    Superior Bank, FSB                  Hinsdale            IL  32646  Superior Federal, FSB       July 27, 2001       August 19, 2014
552    Malta National Bank                 Malta               OH   6629  North Valley Bank           May 3, 2001         November 18, 2002
554    National State Bank of Metropolis   Metropolis          IL   3815  Banterra Bank of Marion     December 14, 2000   March 17, 2005
555    Bank of Honolulu                    Honolulu            HI  21029  Bank of the Orient          October 13, 2000    March 17, 2005

*_
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
;


> library(rvest)
Loading required package: xml2
> library(dplyr)
Attaching package: 'dplyr'
The following objects are masked from 'package:stats':
    filter, lag
The following objects are masked from 'package:base':
    intersect, setdiff, setequal, union
> source("C:/Program Files/R/R-3.3.1/etc/Rprofile.site", echo=T)
> options(help_type = "html")
> URL <- "https://www.fdic.gov/bank/individual/failed/banklist.html"
> want <- URL %>%  read_html() %>%  html_table() %>%  as.data.frame()

NOTE: Processing of R statements complete

12        import r=want  data=wrk.want;
NOTE: Creating data set 'WRK.want' from R data frame 'want'
NOTE: Column names modified during import of 'want'
NOTE: Data set "WRK.want" has 555 observation(s) and 7 variable(s)



