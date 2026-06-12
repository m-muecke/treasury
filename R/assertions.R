require_readxl <- function() {
  if (!requireNamespace("readxl", quietly = TRUE)) {
    stop("Please install the readxl package to use this function.", call. = FALSE)
  }
}

is_count <- function(x, null_ok = FALSE) {
  if (null_ok && is.null(x)) {
    return(TRUE)
  }
  is.numeric(x) && length(x) == 1L && is.finite(x) && as.integer(x) == x && x > 0L
}
