# Daily treasury long-term rates

Treasury ceased publication of the 30-year constant maturity series on
February 18, 2002 and resumed that series on February 9, 2006. To
estimate a 30-year rate during that time frame, this series includes the
Treasury 20-year Constant Maturity rate and an "adjustment factor",
which may be added to the 20-year rate to estimate a 30-year rate during
the period of time in which Treasury did not issue the 30-year bonds.
The adjustment factor is returned in the `extrapolation_factor` column
and is `NA` outside of that period.

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
containing the rates, or `NULL` when no entries were found. The
`updated_at` column gives the feed's last update time as a `POSIXct`
(UTC).

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
#>           date     rate_type  rate extrapolation_factor          updated_at
#>         <Date>        <char> <num>                <num>              <POSc>
#>  1: 2022-12-01       20 year  3.85                   NA 2026-08-05 14:17:56
#>  2: 2022-12-01 over 10 years  3.82                   NA 2026-08-05 14:17:56
#>  3: 2022-12-01     real rate  1.46                   NA 2026-08-05 14:17:56
#>  4: 2022-12-02       20 year  3.79                   NA 2026-08-05 14:17:56
#>  5: 2022-12-02 over 10 years  3.76                   NA 2026-08-05 14:17:56
#>  6: 2022-12-02     real rate  1.31                   NA 2026-08-05 14:17:56
#>  7: 2022-12-05       20 year  3.84                   NA 2026-08-05 14:17:56
#>  8: 2022-12-05 over 10 years  3.81                   NA 2026-08-05 14:17:56
#>  9: 2022-12-05     real rate  1.39                   NA 2026-08-05 14:17:56
#> 10: 2022-12-06       20 year  3.77                   NA 2026-08-05 14:17:56
#> 11: 2022-12-06 over 10 years  3.72                   NA 2026-08-05 14:17:56
#> 12: 2022-12-06     real rate  1.36                   NA 2026-08-05 14:17:56
#> 13: 2022-12-07       20 year  3.66                   NA 2026-08-05 14:17:56
#> 14: 2022-12-07 over 10 years  3.62                   NA 2026-08-05 14:17:56
#> 15: 2022-12-07     real rate  1.29                   NA 2026-08-05 14:17:56
#> 16: 2022-12-08       20 year  3.71                   NA 2026-08-05 14:17:56
#> 17: 2022-12-08 over 10 years  3.66                   NA 2026-08-05 14:17:56
#> 18: 2022-12-08     real rate  1.28                   NA 2026-08-05 14:17:56
#> 19: 2022-12-09       20 year  3.82                   NA 2026-08-05 14:17:56
#> 20: 2022-12-09 over 10 years  3.76                   NA 2026-08-05 14:17:56
#> 21: 2022-12-09     real rate  1.43                   NA 2026-08-05 14:17:56
#> 22: 2022-12-12       20 year  3.84                   NA 2026-08-05 14:17:56
#> 23: 2022-12-12 over 10 years  3.78                   NA 2026-08-05 14:17:56
#> 24: 2022-12-12     real rate  1.44                   NA 2026-08-05 14:17:56
#> 25: 2022-12-13       20 year  3.74                   NA 2026-08-05 14:17:56
#> 26: 2022-12-13 over 10 years  3.70                   NA 2026-08-05 14:17:56
#> 27: 2022-12-13     real rate  1.45                   NA 2026-08-05 14:17:56
#> 28: 2022-12-14       20 year  3.74                   NA 2026-08-05 14:17:56
#> 29: 2022-12-14 over 10 years  3.69                   NA 2026-08-05 14:17:56
#> 30: 2022-12-14     real rate  1.50                   NA 2026-08-05 14:17:56
#> 31: 2022-12-15       20 year  3.69                   NA 2026-08-05 14:17:56
#> 32: 2022-12-15 over 10 years  3.64                   NA 2026-08-05 14:17:56
#> 33: 2022-12-15     real rate  1.48                   NA 2026-08-05 14:17:56
#> 34: 2022-12-16       20 year  3.73                   NA 2026-08-05 14:17:56
#> 35: 2022-12-16 over 10 years  3.69                   NA 2026-08-05 14:17:56
#> 36: 2022-12-16     real rate  1.55                   NA 2026-08-05 14:17:56
#> 37: 2022-12-19       20 year  3.82                   NA 2026-08-05 14:17:56
#> 38: 2022-12-19 over 10 years  3.78                   NA 2026-08-05 14:17:56
#> 39: 2022-12-19     real rate  1.61                   NA 2026-08-05 14:17:56
#> 40: 2022-12-20       20 year  3.94                   NA 2026-08-05 14:17:56
#> 41: 2022-12-20 over 10 years  3.90                   NA 2026-08-05 14:17:56
#> 42: 2022-12-20     real rate  1.64                   NA 2026-08-05 14:17:56
#> 43: 2022-12-21       20 year  3.93                   NA 2026-08-05 14:17:56
#> 44: 2022-12-21 over 10 years  3.90                   NA 2026-08-05 14:17:56
#> 45: 2022-12-21     real rate  1.61                   NA 2026-08-05 14:17:56
#> 46: 2022-12-22       20 year  3.91                   NA 2026-08-05 14:17:56
#> 47: 2022-12-22 over 10 years  3.88                   NA 2026-08-05 14:17:56
#> 48: 2022-12-22     real rate  1.65                   NA 2026-08-05 14:17:56
#> 49: 2022-12-23       20 year  3.99                   NA 2026-08-05 14:17:56
#> 50: 2022-12-23 over 10 years  3.97                   NA 2026-08-05 14:17:56
#> 51: 2022-12-23     real rate  1.72                   NA 2026-08-05 14:17:56
#> 52: 2022-12-27       20 year  4.10                   NA 2026-08-05 14:17:56
#> 53: 2022-12-27 over 10 years  4.07                   NA 2026-08-05 14:17:56
#> 54: 2022-12-27     real rate  1.76                   NA 2026-08-05 14:17:56
#> 55: 2022-12-28       20 year  4.13                   NA 2026-08-05 14:17:56
#> 56: 2022-12-28 over 10 years  4.11                   NA 2026-08-05 14:17:56
#> 57: 2022-12-28     real rate  1.79                   NA 2026-08-05 14:17:56
#> 58: 2022-12-29       20 year  4.09                   NA 2026-08-05 14:17:56
#> 59: 2022-12-29 over 10 years  4.06                   NA 2026-08-05 14:17:56
#> 60: 2022-12-29     real rate  1.74                   NA 2026-08-05 14:17:56
#> 61: 2022-12-30       20 year  4.14                   NA 2026-08-05 14:17:56
#> 62: 2022-12-30 over 10 years  4.11                   NA 2026-08-05 14:17:56
#> 63: 2022-12-30     real rate  1.78                   NA 2026-08-05 14:17:56
#>           date     rate_type  rate extrapolation_factor          updated_at
#>         <Date>        <char> <num>                <num>              <POSc>
# or for the entire year
tr_long_term_rate(2022)
#>            date     rate_type  rate extrapolation_factor          updated_at
#>          <Date>        <char> <num>                <num>              <POSc>
#>   1: 2022-01-03       20 year  2.05                   NA 2026-08-05 14:17:58
#>   2: 2022-01-03 over 10 years  2.00                   NA 2026-08-05 14:17:58
#>   3: 2022-01-03     real rate -0.43                   NA 2026-08-05 14:17:58
#>   4: 2022-01-04       20 year  2.10                   NA 2026-08-05 14:17:58
#>   5: 2022-01-04 over 10 years  2.06                   NA 2026-08-05 14:17:58
#>  ---                                                                        
#> 743: 2022-12-29 over 10 years  4.06                   NA 2026-08-05 14:17:58
#> 744: 2022-12-29     real rate  1.74                   NA 2026-08-05 14:17:58
#> 745: 2022-12-30       20 year  4.14                   NA 2026-08-05 14:17:58
#> 746: 2022-12-30 over 10 years  4.11                   NA 2026-08-05 14:17:58
#> 747: 2022-12-30     real rate  1.78                   NA 2026-08-05 14:17:58
# }
```
