as_tibble <- function(x) {
  if (getOption("treasury.use_tibble", TRUE) &&
    requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(x)
  } else {
    x
  }
}

is_count <- function(x) {
  is.numeric(x) && length(x) == 1L && !is.na(x) &&
    as.integer(x) == x && x > 0L
}

is_count_or_null <- function(x) {
  is.null(x) || is_count(x)
}
