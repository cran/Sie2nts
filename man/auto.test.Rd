% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auto.test.R
\name{auto.test}
\alias{auto.test}
\title{The Test of Stability for Auto-Regressive (AR) Approximations Automatically}
\usage{
auto.test(
  ts,
  or = 4,
  type,
  alpha = 0.05,
  method = "LOOCV",
  threshold = 0,
  B.s = 1000
)
}
\arguments{
\item{ts}{ts is the data set which is a time series data typically}

\item{or}{indicates the order of spline and only used in Cspli type, default is 4 which indicates cubic spline}

\item{type}{type indicates which type of basis is used. There are 31 types in this package}

\item{alpha}{level of the test}

\item{method}{method indicates which method used to choose optimal parameters, 3 methods in this package can be used}

\item{threshold}{threshold determines the bound for Elbow method}

\item{B.s}{the number of statistics used in multiplier bootstrap, the default value is 1000}
}
\value{
p value of the test
}
\description{
auto.test() generates a test of Stability for AR Approximations by choosing tuning parameter automatically.
}
