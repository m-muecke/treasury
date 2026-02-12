# Daily treasury real long-term rate averages

The Long-Term Real Rate Average is the unweighted average of bid real
yields on all outstanding TIPS with remaining maturities of more than 10
years and is intended as a proxy for long-term real rates.

## Usage

``` r
tr_real_long_term(date = NULL)
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
[`tr_long_term_rate()`](https://m-muecke.github.io/treasury/reference/tr_long_term_rate.md),
[`tr_real_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_real_yield_curve.md),
[`tr_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_yield_curve.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# get data for a single month
tr_real_long_term("202201")
# or for the entire year
tr_real_long_term(2022)
} # }
```
