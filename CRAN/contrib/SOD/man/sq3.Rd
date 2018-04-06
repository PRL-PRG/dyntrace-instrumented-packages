\name{sod_sq3-class}
\Rdversion{1.1}
\docType{class}
\alias{sod_sq3-class}
\alias{sod_sq3}
\alias{plot.sod_sq3}

\title{Class \code{sod_sq3}}
\description{
  A named list returned by the DimSqueezer and DimSqueezer_CL squeeze functions.

  The list contains the following members:
  \itemize{
    \item
    stress: The sum of errors in internode distances at each iteration
    of mapping procedure.
    \item
    sq_stress: The sum of the squared errors in internode distances at
    each iteration. To obtain Kruskal stress take the square root 
    after dividing by the total squared distances. See \code{kStress}
    \item
    mapDims: A numeric matrix with one row per iteration and one column
    for each dimension used in the mapping dimension. Values lie between
    0 and 1, with 0 indicating the total elimination of a dimension.
    \item
    pos: A numeric matrix giving the positions of nodes in the target
    dimensionality. The matrix contains a column for all dimensions used
    in the mapping, but only the lower target dimensions denote the
    final positions.
    \item
    node_stress: The sum of errors of node-distances at each node.
    \item
    total_dist: The sum of all internode distances (this is recipocrally
    calculated).
    \item
    total_sq_dist: The sum of the squares of all distances (again
    recipocrally calculated).
  }
  
}
\section{Objects from the Class}{
  Objects are created by the squeeze and squeezeDF functions of the DimSqueezer and
  DimSqueezer_CL objects;
%%  ~~ describe objects here ~~ 
}

%%\section{Slots}{
%%  No slots have been defined for sq3.
%%  \describe{
%%    \item{\code{.S3Class}:}{Object of class \code{"character"} ~~ }
%%  }
%%}

%%\section{Extends}{
%%Class \code{"\linkS4class{oldClass}"}, directly.
%%}
\section{Methods}{
  %%No methods defined with class "sq3" in the signature.
  \describe{
    \item{\code{plot(x, ..., ptype='p')}:}{ Plots either the points or
      the stress in a
      \code{sod_sq3} object. \code{type} determines the type of
      plot. Plotting is carried out by: \code{plotPoints},
      \code{plotConcentric} or \code{plotStress} for values of \code{p},
      \code{c} and \code{s} for \code{type}.
    }
  }
  
}

%%\references{
  %%  ~~put references to the literature/web site here~~
  
%%}

\author{
  %%  ~~who you are~~
  Martin Jakt
}

%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
  \code{\link{SOD-package}}\cr
  \code{\link{DimSqueezer}}\cr 
  \code{\link{DimSqueezer_CL}}\cr
  \code{\link{plotPoints}}\cr
  \code{\link{plotConcentric}}\cr
  \code{\link{plotStress}}
}
\examples{
## see examples for
## DimSqueezer and DimSqueezer_CL
}
\keyword{classes}
