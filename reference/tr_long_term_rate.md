# Daily treasury long-term rates

Treasury ceased publication of the 30-year constant maturity series on
February 18, 2002 and resumed that series on February 9, 2006. To
estimate a 30-year rate during that time frame, this series includes the
Treasury 20-year Constant Maturity rate and an "adjustment factor,"
which may be added to the 20-year rate to estimate a 30-year rate during
the period of time in which Treasury did not issue the 30-year bonds.

## Usage

``` r
tr_long_term_rate(date = NULL)
```

## Source

<https://home.treasury.gov/treasury-daily-interest-rate-xml-feed>

## Arguments

- date:

  (`NULL` \| `character(1)` \| `numeric(1)`)  
  Date in format yyyy or yyyymm. If `NULL`, all data is returned.
  Default `NULL`.

## Value

A
[`data.table::data.table()`](https://rdatatable.gitlab.io/data.table/reference/data.table.html)
containing the rates or `NULL` when no entries were found.

## See also

Other interest rate:
[`tr_bill_rate()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md),
[`tr_real_long_term()`](https://m-muecke.github.io/treasury/reference/tr_real_long_term.md),
[`tr_real_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_real_yield_curve.md),
[`tr_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_yield_curve.md)

## Examples

``` r
# \donttest{
# get data for a single month
tr_long_term_rate("202212")
#>           date     rate_type  rate
#>         <Date>        <char> <num>
#>  1: 2022-12-01       20 year  3.85
#>  2: 2022-12-01 over 10 years  3.82
#>  3: 2022-12-01     real rate  1.46
#>  4: 2022-12-02       20 year  3.79
#>  5: 2022-12-02 over 10 years  3.76
#>  6: 2022-12-02     real rate  1.31
#>  7: 2022-12-05       20 year  3.84
#>  8: 2022-12-05 over 10 years  3.81
#>  9: 2022-12-05     real rate  1.39
#> 10: 2022-12-06       20 year  3.77
#> 11: 2022-12-06 over 10 years  3.72
#> 12: 2022-12-06     real rate  1.36
#> 13: 2022-12-07       20 year  3.66
#> 14: 2022-12-07 over 10 years  3.62
#> 15: 2022-12-07     real rate  1.29
#> 16: 2022-12-08       20 year  3.71
#> 17: 2022-12-08 over 10 years  3.66
#> 18: 2022-12-08     real rate  1.28
#> 19: 2022-12-09       20 year  3.82
#> 20: 2022-12-09 over 10 years  3.76
#> 21: 2022-12-09     real rate  1.43
#> 22: 2022-12-12       20 year  3.84
#> 23: 2022-12-12 over 10 years  3.78
#> 24: 2022-12-12     real rate  1.44
#> 25: 2022-12-13       20 year  3.74
#> 26: 2022-12-13 over 10 years  3.70
#> 27: 2022-12-13     real rate  1.45
#> 28: 2022-12-14       20 year  3.74
#> 29: 2022-12-14 over 10 years  3.69
#> 30: 2022-12-14     real rate  1.50
#> 31: 2022-12-15       20 year  3.69
#> 32: 2022-12-15 over 10 years  3.64
#> 33: 2022-12-15     real rate  1.48
#> 34: 2022-12-16       20 year  3.73
#> 35: 2022-12-16 over 10 years  3.69
#> 36: 2022-12-16     real rate  1.55
#> 37: 2022-12-19       20 year  3.82
#> 38: 2022-12-19 over 10 years  3.78
#> 39: 2022-12-19     real rate  1.61
#> 40: 2022-12-20       20 year  3.94
#> 41: 2022-12-20 over 10 years  3.90
#> 42: 2022-12-20     real rate  1.64
#> 43: 2022-12-21       20 year  3.93
#> 44: 2022-12-21 over 10 years  3.90
#> 45: 2022-12-21     real rate  1.61
#> 46: 2022-12-22       20 year  3.91
#> 47: 2022-12-22 over 10 years  3.88
#> 48: 2022-12-22     real rate  1.65
#> 49: 2022-12-23       20 year  3.99
#> 50: 2022-12-23 over 10 years  3.97
#> 51: 2022-12-23     real rate  1.72
#> 52: 2022-12-27       20 year  4.10
#> 53: 2022-12-27 over 10 years  4.07
#> 54: 2022-12-27     real rate  1.76
#> 55: 2022-12-28       20 year  4.13
#> 56: 2022-12-28 over 10 years  4.11
#> 57: 2022-12-28     real rate  1.79
#> 58: 2022-12-29       20 year  4.09
#> 59: 2022-12-29 over 10 years  4.06
#> 60: 2022-12-29     real rate  1.74
#> 61: 2022-12-30       20 year  4.14
#> 62: 2022-12-30 over 10 years  4.11
#> 63: 2022-12-30     real rate  1.78
#>           date     rate_type  rate
# or for the entire year
tr_long_term_rate(2022)
#>            date     rate_type  rate
#>          <Date>        <char> <num>
#>   1: 2022-01-03       20 year  2.05
#>   2: 2022-01-03 over 10 years  2.00
#>   3: 2022-01-03     real rate -0.43
#>   4: 2022-01-04       20 year  2.10
#>   5: 2022-01-04 over 10 years  2.06
#>  ---                               
#> 743: 2022-12-29 over 10 years  4.06
#> 744: 2022-12-29     real rate  1.74
#> 745: 2022-12-30       20 year  4.14
#> 746: 2022-12-30 over 10 years  4.11
#> 747: 2022-12-30     real rate  1.78
# }
```
