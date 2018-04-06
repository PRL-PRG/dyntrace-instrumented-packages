\name{DimSqueezer_CL-class}
\Rdversion{1.1}
\docType{class}
\alias{DimSqueezer_CL-class}
\alias{DimSqueezer_CL}

\title{Class \code{"DimSqueezer_CL"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
  Provides a reference class that implements the self-organising-deltoids
  (SOD) multi-dimensional-scaling algorithm (MDS) using openCL to
  provide parallel execution on a general purpose GPU.\cr
  New objects are made by calling the initializer using either
  \code{DimSqueezer_CL$new(m)} or \code{new("DimSqueezer_CL", m)}.\cr
  The initializer returns an object from which the methods and fields are accessed
  using the \code{$} operator. See the examples section for usage.
}
\section{Extends}{

All reference classes extend and inherit methods from \code{"\linkS4class{envRefClass}"}.

}
\references{
  %%  ~~put references to the literature/web site here~~
  \url{http://martin.jakt.org.uk/}
}
\author{
  %%  ~~who you are~~
  Martin Jakt
}
%%\note{
  %%  ~~further notes~~
%%}

\section{Warning}{
  \itemize{
    \item{
      This class will only be available on computers where openCL
      functionality is available.\cr
      DANGER: On Mac OSX, it seems possible to crash the
      display driver (i.e. the computer is unusable, though not in a
      completely hung state) if specifying a work group size (\code{wksize}
      argument) that is larger than the
      \code{PREFERRED_WORK_GROUP_SIZE_MULTIPLE}. (This value is printed when
      the class is initialized.)\cr
      Binary distributions of this package are unlikely to provide access this
      class, though that will depend on the compilation environment.
      I have only tested this on
      a small number of computers, and am not sure how it will behave on
      other systems. Precompiled binaries for Windows will by default not
      have access to the openCL functionality.}
    \item{
      This is a reference class that does not follow normal R semantic
      rules. Copying objects does not make new copies, but additional
      references. See \code{?setRefClass} for more details.
    }
    \item{
      This class keeps an external pointer to a C++ object. This object
      will be destroyed at the end of a session. If you wish to use it
      after reloading a session you will need to recreate the
      object. This can be done using the data.matrix field of the
      object (for a DimSqueezer_CL object called ds)\cr
      \code{ds <- DimSqueezer_CL$new( ds$data.matrix ) }
    }
  }
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
\code{\linkS4class{DimSqueezer}}\cr
\code{\link{serialDimFactors}}\cr
\code{\link{parallelDimFactors}}\cr
\code{\link{parallelExpDimFactors}}\cr
\code{\link{sod_sq3}}
}
\examples{
\dontrun{
showClass("DimSqueezer_CL")

## Make an openCL accelerated squeezer object
## note this is only available where both the physical
## hardware and the appropriate development environment
## is available.
data(f186)

## use columns 7:12 as these have comparable data
ds <- DimSqueezer_CL$new( as.matrix(f186[,7:12]) )

## squeeze, 1000 iterations using a work group size of 64
## giving a 2 dimensional representation.
sq <- ds$squeeze(2, 200, 64)

## functions to plot the relationships
plotPoints(sq)

## use columns of f186 to make a more interesting
## plot
plotPoints(sq, col=hsvScale(f186[r,"Etv2"]), pch=19)
plotPoints(sq, col=hsvScale(f186[r,"p_Etv2"]), pch=19)

## and a funky plot
plotConcentric(sq, f186[r,7:12], cex.max=5, pch=19, leg.pos="topleft")

## and to plot the stress mapping.
plotStress(sq1)
}
}

\keyword{classes}
\section{Fields}{
  \describe{
    \item{\code{pointer}:}{Object of class \code{externalptr}
      that refers to the C++ DimSqueezer_CL object (read only).}
    \item{\code{data.matrix}:}{Object of class \code{matrix}
      a numeric matrix used to create the DimSqueezer.}
  }
}
\section{Methods}{
  \describe{
    \item{\code{squeeze(target_dim, iter_no, wksize)}:}{
      Squeezes points into
      \code{target_dim} dimensions in \code{iter_no} iterations using
      an openCL work group size of \code{wksize} (see Warning). 
      Returns a
      named list of class \code{sod_sq3} containing the new coordinates in \code{$pos}, the
      stress evolution in \code{$stress}, the mapping dimensionality in
      \code{mapDims} and the stress (sum error) at each node in \code{node_stress}.
    }
    \item{\code{initialize(m)}:}{
      Initializes the object. m should be a
      numeric matrix (use by calling new as in examples).
    }
  }
}
