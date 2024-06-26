% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yield-curve.R
\name{tr_curve_rate}
\alias{tr_curve_rate}
\alias{tr_par_yields}
\alias{tr_forward_rate}
\title{Download treasury yield curve rates}
\source{
\url{https://home.treasury.gov/data/treasury-coupon-issues-and-corporate-bond-yield-curves}
}
\usage{
tr_curve_rate(
  x = c("hqm", "tnc", "trc", "tbi"),
  type = c("monthly", "end-of-month"),
  year = NULL
)

tr_par_yields(x = c("hqm", "tnc", "trc"), type = c("monthly", "end-of-month"))

tr_forward_rate(
  x = c("tnc", "trc", "tbi"),
  type = c("monthly", "end-of-month")
)
}
\arguments{
\item{x}{\code{character(1)}. Must be one of the following options:
\itemize{
\item \code{"hqm"}: The Treasury High Quality Market (HQM) Corporate Bond Yield Curve.
\item \code{"tnc"}: The Treasury Nominal Coupon-Issue (TNC) Yield Curve.
\item \code{"trc"}: The Treasury Real Coupon-Issue (TRC) Yield Curve.
\item \code{"tbi"}: The Treasury Breakeven Inflation (TBI) Curve.
}}

\item{type}{\code{character(1)}. Either \code{"monthly"} or \code{"end-of-month"}.
Default is \code{"monthly"}.}

\item{year}{\code{integer(1)}. Year to download. Default is \code{NULL}.
If \code{NULL}, then all available years are downloaded.}
}
\value{
A \code{data.frame()} with the following columns: \code{yearmonth}, \code{maturity}, \code{rate}.
}
\description{
Download treasury yield curve rates
}
\examples{
\dontrun{
tr_curve_rate("tbi")
tr_curve_rate("trc", "end-of-month", 2024L)
}
}
\concept{yield curve}
