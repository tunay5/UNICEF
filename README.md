
# UNICEF Package

This package will allow you to fetch datasets from the sdmx API of
UNICEF.

## Install Package

In order to install UNICEF package, you have to first install devtools
package

``` r
install.packages("devtools")
library(devtools)
```

And then install our package and add to library

``` r
install_github("tunay5/UNICEF",force = TRUE)
library(UNICEF)
```

## dataflows()

This code will return the dataflows included in UNICEF database. It also
include other features of dataflows, such as its agency id, name and
dataflow id.

``` r
dataflows()
```

    ##                          data_flow_name       dataflow       data_flow_id
    ## 1                 Brazil Country Office      BRAZIL_CO      DSD_BRAZIL_CO
    ## 2                           Brazil SELO BRAZIL_CO_SELO DSD_BRAZIL_CO_SELO
    ## 3                              CAP 2030        CAP2030            CAP2030
    ## 4                         Coundown 2030         CD2030             CD2030
    ## 5       Countdown - coverage indicators          CDCOV              CDCOV
    ## 6    Countdown - demographic indicators          CDDEM              CDDEM
    ## 7        Countdown - drivers indicators       CDDRIVER           CDDRIVER
    ## 8  Countdown - coverage - equiplot data     CDEQUIPLOT         CDEQUIPLOT
    ## 9         Countdown - tier 2 indicators           CDT2               CDT2
    ## 10                           CD2030 All   CONSOLIDATED         CD2030_ALL
    ##    data_flow_agencyID
    ## 1           BRAZIL_CO
    ## 2           BRAZIL_CO
    ## 3             CAP2030
    ## 4              CD2030
    ## 5              CD2030
    ## 6              CD2030
    ## 7              CD2030
    ## 8              CD2030
    ## 9              CD2030
    ## 10             CD2030

## get_data(dataflow, filter = NULL, start = NULL, end = NULL)

With the function, you will be able to fetch data based on the dataflow
and filter features, from the database of UNICEF.

For example, if you want to fetch the data of child mortality rate
(under 5 years old) in São Paulo, from the years of 2010 and 2012:

``` r
get_data("BRAZIL_CO", filter = c("SP.MORTALIDADEINFANCIAMENOR5.."), start = 2010, end = 2012)
```

    ## [[1]]
    ##   TIME_PERIOD OBS_VALUE                             DATA_SOURCE
    ## 1        2010      13.9 MS/SVS/CGIAE - SIM/Sinasc e Busca Ativa
    ## 2        2011      13.4 MS/SVS/CGIAE - SIM/Sinasc e Busca Ativa
    ## 3        2012      13.3 MS/SVS/CGIAE - SIM/Sinasc e Busca Ativa

## Notes

To check the data queries, metadata and reach to the database, check:
<https://sdmx.data.unicef.org/overview.html>

To understand the sdmx API of UNICEF:
<https://data.unicef.org/sdmx-api-documentation/>
