\name{SOD.stress.functions}
\alias{nStress}
\alias{kStress}

\title{SOD normalised stress values}
\description{
  Functions that return stress values normalised by the total distance
  between nodes.
  \itemize{
    \item
    \code{kStress} returns a vector of Kruskal stress (sum of
    squared errors) / (squared distances).
    \item
    \code{nStress} returns a vector of absolute errors divided by the
    sum of all distances.
  }
}

\usage{
nStress(sq)

kStress(sq)
}

\arguments{
  \item{sq}{A named list produced by a squeeze function of 
    class \code{sod_sq3}.
  }
}


\seealso{
  \code{\link{SOD-package}}\cr
  \code{\link{DimSqueezer}}\cr 
  \code{\link{DimSqueezer_CL}} 
}

\examples{
## please see examples in the SOD documentation package
## ?SOD
##
}
