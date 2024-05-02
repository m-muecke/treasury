
<!-- README.md is generated from README.Rmd. Please edit that file -->

# treasury

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/m-muecke/treasury/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/m-muecke/treasury/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/treasury)](https://CRAN.R-project.org/package=treasury)
<!-- badges: end -->

## Overview

The goal of treasury is to provide a simple and modern interface to the
[US treasury XML
feed](https://home.treasury.gov/treasury-daily-interest-rate-xml-feed)
for daily interest rates.

## Installation

You can install the released version of **treasury** from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("treasury")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("m-muecke/treasury")
```

## Usage

treasury functions are prefixed with `tr_` and follow the naming
convention of the XML feed.

``` r
library(treasury)

yield_curve <- tr_yield_curve(2023)
yield_curve
#> # A tibble: 3,250 × 3
#>   date       maturity  rate
#>   <date>     <chr>    <dbl>
#> 1 2023-01-03 1 month   4.17
#> 2 2023-01-03 2 month   4.42
#> 3 2023-01-03 3 month   4.53
#> 4 2023-01-03 4 month   4.7 
#> 5 2023-01-03 6 month   4.77
#> # ℹ 3,245 more rows
```

<img src="man/figures/README-plot-1.png" width="100%" />

## Related work

- [ustyc](https://github.com/mrbcuda/ustyc) - R package to download and
  parse the US Treasury yield curve data
- [ustfd](https://github.com/groditi/ustfd) - R client for US Treasury
  Fiscal Data API
