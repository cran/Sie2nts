# pacf by cv


source(paste(getwd(), "/R/Sie2nts.Legen.v1.R", sep = ""))
source(paste(getwd(), "/R/Sie2nts.Cheby.v1.R", sep = ""))
source(paste(getwd(), "/R/Sie2nts.Four.v1.R", sep = ""))
source(paste(getwd(), "/R/Sie2nts.Csp.v1.R", sep = ""))
source(paste(getwd(), "/R/Sie2nts.db1-20.v1.R", sep = ""))



#' Generate Partial Autocorrelation Function (PACF) Automatically
#' @description sie.auto.pacf() generates the PACF from 1 to lag automatically.
#' @param ts ts is the data set which is a time series data typically
#' @param c c indicates the number of basis used to estimate (For wavelet, the number of basis is 2^c.If
#'     Cspli is chosen, the real number of basis is c-2+or)
#' @param lag lag b is the lag for auto-regressive model
#'
#' @param type type indicates which type of basis is used (There are 31 types in this package)
#' @param or indicates the order of spline and only used in Cspli type, default is 4 which indicates cubic spline
#' @param m m indicates the number of points of coefficients to estimate
#'
#' @return A list contains the PACF in each lag
#' @export
#'
#' @examples
#' set.seed(137)
#' time.series = c()
#' n = 1024
#' v = 25
#' w = rnorm(n, 0, 1) / v
#' x_ini = runif(1,0,1)

#' for(i in 1:n){
#'   if(i == 1){
#'     time.series[i] = 0.2 + 0.6*cos(2*pi*(i/n))*x_ini  + w[i] #
#'   } else{
#'     time.series[i] = 0.2 + 0.6*cos(2*pi*(i/n))*time.series[i-1] + w[i]
#'   }
#' }
#' sie.auto.pacf(time.series, 5, 1, "Legen")




sie.auto.pacf = function(ts, c, lag, type, or=4, m=500){
  wavelet_basis = c("db1", "db2", "db3", "db4", "db5",
                    "db6", "db7", "db8", "db9", "db10",
                    "db11", "db12", "db13", "db14", "db15",
                    "db16", "db17", "db18", "db19", "db20",
                    "cf1", "cf2", "cf3", "cf4", "cf5"
  )

  if(type == "Legen"){
    if(lag == 1){
      res = fix.fit.legen(ts, c, 1, m)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      return(val)
    } else{
      res = fix.fit.legen(ts, c, 1, m)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      for(b in 2:lag){
        res = fix.fit.legen(ts, c, b, m)
        val[[b]] = res$ts.coef[[b+1]]
      }
      return(val)
    }
  } else if (type == "Cheby"){
    if(lag == 1){
      res = fix.fit.cheby(ts, c, 1, m)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      return(val)
    } else{
      res = fix.fit.cheby(ts, c, 1, m)
      val = list()
      val[[1]] =  res$ts.coef[[1+1]]
      for(b in 2:lag){
        res = fix.fit.cheby(ts, c, b, m)
        val[[b]] = res$ts.coef[[b+1]]
      }
      return(val)
    }
  } else if (type %in% c("tri", "cos", "sin")){
    if(lag == 1){
      res = fix.fit.four(ts, c, 1, m, ops = type)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      return(val)
    } else{
      res = fix.fit.four(ts, c, 1, m, ops = type)
      val = list()
      val[[1]] =  res$ts.coef[[1+1]]
      for(b in 2:lag){
        res = fix.fit.four(ts, c, b, m, ops = type)
        val[[b]] = res$ts.coef[[b+1]]
      }
      return(val)
    }
  } else if (type == "Cspli"){
    if(lag == 1){
      res = fix.fit.cspline(ts, c, 1,or = or, m)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      return(val)
    } else{
      res = fix.fit.cspline(ts, c, 1,or = or, m)
      val = list()
      val[[1]] =  res$ts.coef[[1+1]]
      for(b in 2:lag){
        res = fix.fit.cspline(ts, c, b,or =or, m)
        val[[b]] = res$ts.coef[[b+1]]
      }
      return(val)
    }
  } else if (type %in% wavelet_basis){
    if(lag == 1){
      res = fix.fit.wavelet(ts, c, 1, m, ops = type)
      val = list()
      val[[1]] =  res$ts.coef[[2]]
      return(val)
    } else{
      res = fix.fit.wavelet(ts, c, 1, m, ops = type)
      val = list()
      val[[1]] =  res$ts.coef[[1+1]]
      for(b in 2:lag){
        res = fix.fit.wavelet(ts, c, b, m, ops = type)
        val[[b]] = res$ts.coef[[b+1]]
      }
      return(val)
    }
  } else{
    return(stop("Invalid option!"))
  }
}











