# Daily treasury par yield curve rates

This par yield curve, which relates the par yield on a security to its
time to maturity, is based on the closing market bid prices on the most
recently auctioned Treasury securities in the over-the-counter market.
The par yields are derived from input market prices, which are
indicative quotations obtained by the Federal Reserve Bank of New York
at approximately 3:30 PM each business day.

## Usage

``` r
tr_yield_curve(date = NULL)
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
[`tr_long_term_rate()`](https://m-muecke.github.io/treasury/reference/tr_long_term_rate.md),
[`tr_real_long_term()`](https://m-muecke.github.io/treasury/reference/tr_real_long_term.md),
[`tr_real_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_real_yield_curve.md)

## Examples

``` r
# \donttest{
# get data for a single month
tr_yield_curve("202201")
#>            date maturity  rate          updated_at
#>          <Date>   <char> <num>              <POSc>
#>   1: 2022-01-03  1 month  0.05 2026-08-22 02:37:47
#>   2: 2022-01-03  2 month  0.06 2026-08-22 02:37:47
#>   3: 2022-01-03  3 month  0.08 2026-08-22 02:37:47
#>   4: 2022-01-03  6 month  0.22 2026-08-22 02:37:47
#>   5: 2022-01-03   1 year  0.40 2026-08-22 02:37:47
#>  ---                                              
#> 236: 2022-01-31   5 year  1.62 2026-08-22 02:37:47
#> 237: 2022-01-31   7 year  1.75 2026-08-22 02:37:47
#> 238: 2022-01-31  10 year  1.79 2026-08-22 02:37:47
#> 239: 2022-01-31  20 year  2.17 2026-08-22 02:37:47
#> 240: 2022-01-31  30 year  2.11 2026-08-22 02:37:47
# or for the entire year
tr_yield_curve(2022)
#>             date maturity  rate          updated_at
#>           <Date>   <char> <num>              <POSc>
#>    1: 2022-01-03  1 month  0.05 2026-08-21 15:59:44
#>    2: 2022-01-03  2 month  0.06 2026-08-21 15:59:44
#>    3: 2022-01-03  3 month  0.08 2026-08-21 15:59:44
#>    4: 2022-01-03  6 month  0.22 2026-08-21 15:59:44
#>    5: 2022-01-03   1 year  0.40 2026-08-21 15:59:44
#>   ---                                              
#> 3034: 2022-12-30   5 year  3.99 2026-08-21 15:59:44
#> 3035: 2022-12-30   7 year  3.96 2026-08-21 15:59:44
#> 3036: 2022-12-30  10 year  3.88 2026-08-21 15:59:44
#> 3037: 2022-12-30  20 year  4.14 2026-08-21 15:59:44
#> 3038: 2022-12-30  30 year  3.97 2026-08-21 15:59:44
# }
```
