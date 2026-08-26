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
#>  1: 2022-12-01       20 year  3.85                   NA 2026-08-26 12:45:20
#>  2: 2022-12-01 over 10 years  3.82                   NA 2026-08-26 12:45:20
#>  3: 2022-12-01     real rate  1.46                   NA 2026-08-26 12:45:20
#>  4: 2022-12-02       20 year  3.79                   NA 2026-08-26 12:45:20
#>  5: 2022-12-02 over 10 years  3.76                   NA 2026-08-26 12:45:20
#>  6: 2022-12-02     real rate  1.31                   NA 2026-08-26 12:45:20
#>  7: 2022-12-05       20 year  3.84                   NA 2026-08-26 12:45:20
#>  8: 2022-12-05 over 10 years  3.81                   NA 2026-08-26 12:45:20
#>  9: 2022-12-05     real rate  1.39                   NA 2026-08-26 12:45:20
#> 10: 2022-12-06       20 year  3.77                   NA 2026-08-26 12:45:20
#> 11: 2022-12-06 over 10 years  3.72                   NA 2026-08-26 12:45:20
#> 12: 2022-12-06     real rate  1.36                   NA 2026-08-26 12:45:20
#> 13: 2022-12-07       20 year  3.66                   NA 2026-08-26 12:45:20
#> 14: 2022-12-07 over 10 years  3.62                   NA 2026-08-26 12:45:20
#> 15: 2022-12-07     real rate  1.29                   NA 2026-08-26 12:45:20
#> 16: 2022-12-08       20 year  3.71                   NA 2026-08-26 12:45:20
#> 17: 2022-12-08 over 10 years  3.66                   NA 2026-08-26 12:45:20
#> 18: 2022-12-08     real rate  1.28                   NA 2026-08-26 12:45:20
#> 19: 2022-12-09       20 year  3.82                   NA 2026-08-26 12:45:20
#> 20: 2022-12-09 over 10 years  3.76                   NA 2026-08-26 12:45:20
#> 21: 2022-12-09     real rate  1.43                   NA 2026-08-26 12:45:20
#> 22: 2022-12-12       20 year  3.84                   NA 2026-08-26 12:45:20
#> 23: 2022-12-12 over 10 years  3.78                   NA 2026-08-26 12:45:20
#> 24: 2022-12-12     real rate  1.44                   NA 2026-08-26 12:45:20
#> 25: 2022-12-13       20 year  3.74                   NA 2026-08-26 12:45:20
#> 26: 2022-12-13 over 10 years  3.70                   NA 2026-08-26 12:45:20
#> 27: 2022-12-13     real rate  1.45                   NA 2026-08-26 12:45:20
#> 28: 2022-12-14       20 year  3.74                   NA 2026-08-26 12:45:20
#> 29: 2022-12-14 over 10 years  3.69                   NA 2026-08-26 12:45:20
#> 30: 2022-12-14     real rate  1.50                   NA 2026-08-26 12:45:20
#> 31: 2022-12-15       20 year  3.69                   NA 2026-08-26 12:45:20
#> 32: 2022-12-15 over 10 years  3.64                   NA 2026-08-26 12:45:20
#> 33: 2022-12-15     real rate  1.48                   NA 2026-08-26 12:45:20
#> 34: 2022-12-16       20 year  3.73                   NA 2026-08-26 12:45:20
#> 35: 2022-12-16 over 10 years  3.69                   NA 2026-08-26 12:45:20
#> 36: 2022-12-16     real rate  1.55                   NA 2026-08-26 12:45:20
#> 37: 2022-12-19       20 year  3.82                   NA 2026-08-26 12:45:20
#> 38: 2022-12-19 over 10 years  3.78                   NA 2026-08-26 12:45:20
#> 39: 2022-12-19     real rate  1.61                   NA 2026-08-26 12:45:20
#> 40: 2022-12-20       20 year  3.94                   NA 2026-08-26 12:45:20
#> 41: 2022-12-20 over 10 years  3.90                   NA 2026-08-26 12:45:20
#> 42: 2022-12-20     real rate  1.64                   NA 2026-08-26 12:45:20
#> 43: 2022-12-21       20 year  3.93                   NA 2026-08-26 12:45:20
#> 44: 2022-12-21 over 10 years  3.90                   NA 2026-08-26 12:45:20
#> 45: 2022-12-21     real rate  1.61                   NA 2026-08-26 12:45:20
#> 46: 2022-12-22       20 year  3.91                   NA 2026-08-26 12:45:20
#> 47: 2022-12-22 over 10 years  3.88                   NA 2026-08-26 12:45:20
#> 48: 2022-12-22     real rate  1.65                   NA 2026-08-26 12:45:20
#> 49: 2022-12-23       20 year  3.99                   NA 2026-08-26 12:45:20
#> 50: 2022-12-23 over 10 years  3.97                   NA 2026-08-26 12:45:20
#> 51: 2022-12-23     real rate  1.72                   NA 2026-08-26 12:45:20
#> 52: 2022-12-27       20 year  4.10                   NA 2026-08-26 12:45:20
#> 53: 2022-12-27 over 10 years  4.07                   NA 2026-08-26 12:45:20
#> 54: 2022-12-27     real rate  1.76                   NA 2026-08-26 12:45:20
#> 55: 2022-12-28       20 year  4.13                   NA 2026-08-26 12:45:20
#> 56: 2022-12-28 over 10 years  4.11                   NA 2026-08-26 12:45:20
#> 57: 2022-12-28     real rate  1.79                   NA 2026-08-26 12:45:20
#> 58: 2022-12-29       20 year  4.09                   NA 2026-08-26 12:45:20
#> 59: 2022-12-29 over 10 years  4.06                   NA 2026-08-26 12:45:20
#> 60: 2022-12-29     real rate  1.74                   NA 2026-08-26 12:45:20
#> 61: 2022-12-30       20 year  4.14                   NA 2026-08-26 12:45:20
#> 62: 2022-12-30 over 10 years  4.11                   NA 2026-08-26 12:45:20
#> 63: 2022-12-30     real rate  1.78                   NA 2026-08-26 12:45:20
#>           date     rate_type  rate extrapolation_factor          updated_at
#>         <Date>        <char> <num>                <num>              <POSc>
# or for the entire year
tr_long_term_rate(2022)
#>            date     rate_type  rate extrapolation_factor          updated_at
#>          <Date>        <char> <num>                <num>              <POSc>
#>   1: 2022-01-03       20 year  2.05                   NA 2026-08-26 02:11:26
#>   2: 2022-01-03 over 10 years  2.00                   NA 2026-08-26 02:11:26
#>   3: 2022-01-03     real rate -0.43                   NA 2026-08-26 02:11:26
#>   4: 2022-01-04       20 year  2.10                   NA 2026-08-26 02:11:26
#>   5: 2022-01-04 over 10 years  2.06                   NA 2026-08-26 02:11:26
#>  ---                                                                        
#> 743: 2022-12-29 over 10 years  4.06                   NA 2026-08-26 02:11:26
#> 744: 2022-12-29     real rate  1.74                   NA 2026-08-26 02:11:26
#> 745: 2022-12-30       20 year  4.14                   NA 2026-08-26 02:11:26
#> 746: 2022-12-30 over 10 years  4.11                   NA 2026-08-26 02:11:26
#> 747: 2022-12-30     real rate  1.78                   NA 2026-08-26 02:11:26
# }
```
