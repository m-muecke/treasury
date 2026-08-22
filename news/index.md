# Changelog

## treasury (development version)

- The daily interest rate functions no longer emit a spurious data.table
  shallow copy warning when downloading the full history with
  `date = NULL`.
- [`tr_curve_rate()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
  now rejects a `year` outside the range of available data with an
  informative error instead of silently returning an empty table.
- [`tr_forward_rate()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
  and
  [`tr_par_yield()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
  now return the `type` and `maturity` columns, respectively, as
  character vectors instead of factors, for consistency with the other
  functions in the package.

## treasury 0.6.0

CRAN release: 2026-07-11

- The daily interest rate functions now include an `updated_at` column
  with the feed’s last update time.
- The daily interest rate functions now reject an invalid `date`, such
  as a month outside 01-12, with an informative error instead of
  silently returning no data.
- [`tr_bill_rate()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md)
  now includes `maturity_date` and `cusip` columns identifying the bill
  quoted for each maturity tranche.
- [`tr_curve_rate()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md),
  [`tr_par_yield()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md),
  and
  [`tr_forward_rate()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
  now parse dates correctly regardless of the session’s locale
  (previously failed under non-English locales).
- [`tr_long_term_rate()`](https://m-muecke.github.io/treasury/reference/tr_long_term_rate.md)
  now includes an `extrapolation_factor` column with the adjustment
  factor used to estimate 30-year rates between 2002 and 2006 (`NA`
  outside of that period).
- [`tr_yield_curve()`](https://m-muecke.github.io/treasury/reference/tr_yield_curve.md)
  now correctly labels the 1.5-month maturity (previously shown as
  `1 _5month`).

## treasury 0.5.0

CRAN release: 2026-03-21

- Add optional caching of API responses via
  `options(treasury.cache = TRUE)`. Cached responses are stored for 1
  day by default and can be customized with
  `options(treasury.cache_max_age = seconds)`. Use
  [`tr_cache_dir()`](https://m-muecke.github.io/treasury/reference/tr_cache_dir.md)
  to find the cache location and
  [`tr_cache_clear()`](https://m-muecke.github.io/treasury/reference/tr_cache_dir.md)
  to clear it.

## treasury 0.4.0

CRAN release: 2025-08-26

- Fixed bug in checking for {readxl} installation.
- Improved documentation.
- Renamed functions for consistency:
  - [`tr_bill_rates()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md)
    to
    [`tr_bill_rate()`](https://m-muecke.github.io/treasury/reference/tr_bill_rate.md)
  - [`tr_par_yields()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)
    to
    [`tr_par_yield()`](https://m-muecke.github.io/treasury/reference/tr_curve_rate.md)

## treasury 0.3.0

CRAN release: 2025-07-10

- Migration to data.table package. Internal data manipulation is now
  done using data.table and all functions return data.table objects.

## treasury 0.2.0

CRAN release: 2024-07-05

- Better documentation.
- Support for Treasury High Quality Market (HQM) Corporate Bond Yield
  Curve data.
- Support for Treasury Nominal Coupon-Issue (TNC) Yield Curve data.
- Support for Treasury Real Coupon-Issue (TRC) Yield Curve data.
- Support for Treasury Breakeven Inflation Curve (TBI curve) data.

## treasury 0.1.0

CRAN release: 2024-03-22

- Initial CRAN submission.
