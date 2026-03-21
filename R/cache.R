#' Get or manage the treasury API cache
#'
#' `tr_cache_dir()` returns the path where cached API responses are stored.
#' `tr_cache_clear()` clears all cached responses.
#'
#' @details
#' The cache is only used when enabled with `options(treasury.cache = TRUE)`.
#' Cached responses are stored for 1 day by default, but this can be customized with
#' `options(treasury.cache_max_age = seconds)`.
#'
#' @returns
#' * `tr_cache_dir()`: A string with the path to the cache directory.
#' * `tr_cache_clear()`: No return value, called for side effects.
#' @export
#' @examples
#' tr_cache_dir()
tr_cache_dir <- function() {
  file.path(tools::R_user_dir("treasury", "cache"), "httr2")
}

#' @rdname tr_cache_dir
#' @export
tr_cache_clear <- function() {
  cache_dir <- tr_cache_dir()
  if (dir.exists(cache_dir)) {
    unlink(dir(cache_dir, full.names = TRUE))
  }
  invisible()
}

req_tr_cache <- function(req) {
  if (isTRUE(getOption("treasury.cache", FALSE))) {
    req <- req_cache(
      req,
      path = tr_cache_dir(),
      max_age = getOption("treasury.cache_max_age", 86400L)
    )
  }
  req
}
