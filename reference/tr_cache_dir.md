# Get or manage the treasury API cache

`tr_cache_dir()` returns the path where cached API responses are stored.
`tr_cache_clear()` clears all cached responses.

## Usage

``` r
tr_cache_dir()

tr_cache_clear()
```

## Value

- `tr_cache_dir()`: A string with the path to the cache directory.

- `tr_cache_clear()`: No return value, called for side effects.

## Details

The cache is only used when enabled with
`options(treasury.cache = TRUE)`. Cached responses are stored for 1 day
by default, but this can be customized with
`options(treasury.cache_max_age = seconds)`.

## Examples

``` r
tr_cache_dir()
#> [1] "/home/runner/.cache/R/treasury/httr2"
```
