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
[`data.table::data.table()`](https://rdrr.io/pkg/data.table/man/data.table.html)
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
#>           date     rate_type  rate          updated_at
#>         <Date>        <char> <num>              <POSc>
#>  1: 2022-12-01       20 year  3.85 2026-06-29 14:41:04
#>  2: 2022-12-01 over 10 years  3.82 2026-06-29 14:41:04
#>  3: 2022-12-01     real rate  1.46 2026-06-29 14:41:04
#>  4: 2022-12-02       20 year  3.79 2026-06-29 14:41:04
#>  5: 2022-12-02 over 10 years  3.76 2026-06-29 14:41:04
#>  6: 2022-12-02     real rate  1.31 2026-06-29 14:41:04
#>  7: 2022-12-05       20 year  3.84 2026-06-29 14:41:04
#>  8: 2022-12-05 over 10 years  3.81 2026-06-29 14:41:04
#>  9: 2022-12-05     real rate  1.39 2026-06-29 14:41:04
#> 10: 2022-12-06       20 year  3.77 2026-06-29 14:41:04
#> 11: 2022-12-06 over 10 years  3.72 2026-06-29 14:41:04
#> 12: 2022-12-06     real rate  1.36 2026-06-29 14:41:04
#> 13: 2022-12-07       20 year  3.66 2026-06-29 14:41:04
#> 14: 2022-12-07 over 10 years  3.62 2026-06-29 14:41:04
#> 15: 2022-12-07     real rate  1.29 2026-06-29 14:41:04
#> 16: 2022-12-08       20 year  3.71 2026-06-29 14:41:04
#> 17: 2022-12-08 over 10 years  3.66 2026-06-29 14:41:04
#> 18: 2022-12-08     real rate  1.28 2026-06-29 14:41:04
#> 19: 2022-12-09       20 year  3.82 2026-06-29 14:41:04
#> 20: 2022-12-09 over 10 years  3.76 2026-06-29 14:41:04
#> 21: 2022-12-09     real rate  1.43 2026-06-29 14:41:04
#> 22: 2022-12-12       20 year  3.84 2026-06-29 14:41:04
#> 23: 2022-12-12 over 10 years  3.78 2026-06-29 14:41:04
#> 24: 2022-12-12     real rate  1.44 2026-06-29 14:41:04
#> 25: 2022-12-13       20 year  3.74 2026-06-29 14:41:04
#> 26: 2022-12-13 over 10 years  3.70 2026-06-29 14:41:04
#> 27: 2022-12-13     real rate  1.45 2026-06-29 14:41:04
#> 28: 2022-12-14       20 year  3.74 2026-06-29 14:41:04
#> 29: 2022-12-14 over 10 years  3.69 2026-06-29 14:41:04
#> 30: 2022-12-14     real rate  1.50 2026-06-29 14:41:04
#> 31: 2022-12-15       20 year  3.69 2026-06-29 14:41:04
#> 32: 2022-12-15 over 10 years  3.64 2026-06-29 14:41:04
#> 33: 2022-12-15     real rate  1.48 2026-06-29 14:41:04
#> 34: 2022-12-16       20 year  3.73 2026-06-29 14:41:04
#> 35: 2022-12-16 over 10 years  3.69 2026-06-29 14:41:04
#> 36: 2022-12-16     real rate  1.55 2026-06-29 14:41:04
#> 37: 2022-12-19       20 year  3.82 2026-06-29 14:41:04
#> 38: 2022-12-19 over 10 years  3.78 2026-06-29 14:41:04
#> 39: 2022-12-19     real rate  1.61 2026-06-29 14:41:04
#> 40: 2022-12-20       20 year  3.94 2026-06-29 14:41:04
#> 41: 2022-12-20 over 10 years  3.90 2026-06-29 14:41:04
#> 42: 2022-12-20     real rate  1.64 2026-06-29 14:41:04
#> 43: 2022-12-21       20 year  3.93 2026-06-29 14:41:04
#> 44: 2022-12-21 over 10 years  3.90 2026-06-29 14:41:04
#> 45: 2022-12-21     real rate  1.61 2026-06-29 14:41:04
#> 46: 2022-12-22       20 year  3.91 2026-06-29 14:41:04
#> 47: 2022-12-22 over 10 years  3.88 2026-06-29 14:41:04
#> 48: 2022-12-22     real rate  1.65 2026-06-29 14:41:04
#> 49: 2022-12-23       20 year  3.99 2026-06-29 14:41:04
#> 50: 2022-12-23 over 10 years  3.97 2026-06-29 14:41:04
#> 51: 2022-12-23     real rate  1.72 2026-06-29 14:41:04
#> 52: 2022-12-27       20 year  4.10 2026-06-29 14:41:04
#> 53: 2022-12-27 over 10 years  4.07 2026-06-29 14:41:04
#> 54: 2022-12-27     real rate  1.76 2026-06-29 14:41:04
#> 55: 2022-12-28       20 year  4.13 2026-06-29 14:41:04
#> 56: 2022-12-28 over 10 years  4.11 2026-06-29 14:41:04
#> 57: 2022-12-28     real rate  1.79 2026-06-29 14:41:04
#> 58: 2022-12-29       20 year  4.09 2026-06-29 14:41:04
#> 59: 2022-12-29 over 10 years  4.06 2026-06-29 14:41:04
#> 60: 2022-12-29     real rate  1.74 2026-06-29 14:41:04
#> 61: 2022-12-30       20 year  4.14 2026-06-29 14:41:04
#> 62: 2022-12-30 over 10 years  4.11 2026-06-29 14:41:04
#> 63: 2022-12-30     real rate  1.78 2026-06-29 14:41:04
#>           date     rate_type  rate          updated_at
#>         <Date>        <char> <num>              <POSc>
# or for the entire year
tr_long_term_rate(2022)
#>            date     rate_type  rate          updated_at
#>          <Date>        <char> <num>              <POSc>
#>   1: 2022-01-03       20 year  2.05 2026-06-29 14:41:06
#>   2: 2022-01-03 over 10 years  2.00 2026-06-29 14:41:06
#>   3: 2022-01-03     real rate -0.43 2026-06-29 14:41:06
#>   4: 2022-01-04       20 year  2.10 2026-06-29 14:41:06
#>   5: 2022-01-04 over 10 years  2.06 2026-06-29 14:41:06
#>  ---                                                   
#> 743: 2022-12-29 over 10 years  4.06 2026-06-29 14:41:06
#> 744: 2022-12-29     real rate  1.74 2026-06-29 14:41:06
#> 745: 2022-12-30       20 year  4.14 2026-06-29 14:41:06
#> 746: 2022-12-30 over 10 years  4.11 2026-06-29 14:41:06
#> 747: 2022-12-30     real rate  1.78 2026-06-29 14:41:06
# }
```
