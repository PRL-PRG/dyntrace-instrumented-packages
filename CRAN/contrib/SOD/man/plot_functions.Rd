\name{SOD.plot.functions}
\alias{plotPoints}
\alias{plotConcentric}
\alias{plotStress}

\title{SOD plotting functions}
\description{
  Functions for visualising points mapped by the SOD algorithm,
  \itemize{
    \item
    \code{plotPoints} plots mapped points
    \item
    \code{plotConcentric} fancy plots of points
    \item
    \code{plotStress} plots the change of the sum of errors in the
    inter-node distances.
  }
  These are simple convenience functions that mainly serve as examples
  that the user may wish to extend. The package also provides a generic
  plot function for the \code{sod_sq3} class returned by the squeeze
  functions. This generic function simply calls one of these functions
  depending upon the value of the \code{ptype} parameter see
  \code{?sod_sq3} and examples section for details.

  %% if latex we can put a plot here
  \if{latex}{
    \figure{plots.pdf}\cr
    Plots showing the positions of points after mapping (A-C) and the
    evolution of stress during the mapping process (D). In A and B the
    colour indicates either the level of stress (A) or the density of
    Etv2 transcripts (B) for each point. In C, the transcript densities
    of all the indicated genes are shown; the visible area of each
    concentric circle is proportional to the indicated transcripts. In
    D, the total amount of stress (sum of differences between distances
    in the original and reduced dimensionality spaces) at each iteration
    is plotted against a background indicating the dimensionality of the
    plotting space. The commands used to create the plots are shown in
    the titles.
  }
}

\usage{
plotPoints(x, col=hsvScale(x$node_stress), xc=1, yc=2,
           invert.y=FALSE, xlab=NA, ylab=NA, ...)

plotConcentric(x, cex.data, col=hsvScale(1:ncol(cex.data)),xc=1,
               yc=2, cex.max=3, invert.y=FALSE, pch=19, xlab=NA,
               ylab=NA, leg.pos=NULL, ...)

plotStress(x, bg.alpha=0.5, bg.sat=1, bg.val=0.75, col='black', lwd=1,
           lty=1, main="Error / Dimension",
           xlab="iteration", ylab="error / dimensionality", ...)

}

\arguments{
  \item{x}{A named list produced by the squeeze functions containing
    'stress', 'mapDims', 'pos', 'time', 'node_stress'.}
  \item{col}{A vector of colours for each row of sq$pos, or for
    plotConcentric a colour for each column of cex.data. For
    plotStress the \code{col} argument gives the colour for points plotted.}
  \item{xc}{The dimension to plot on the x-axis.}
  \item{yc}{The dimension to plot on the y-axis.}
  \item{invert.y}{A boolean determining whether the y-axis should be inverted}
  \item{pch}{The plot character to use. Defaults to 19 (solid circles)
    for plotConcentric.}
  \item{cex.max}{The size of the points representing maximal values for
    plotConcentric.}
  \item{cex.data}{A numeric matrix providing numerical descriptions of
    the items represented by each point (1 row per point). Each column
    represents a numerical descriptor of some sort, and will be
    plotted as a series of concentric discs or circles where the incremental
    area of each disc/circle is proportional to the value scaled across all
    columns.}
  \item{leg.pos}{The position of an optional legend. If NULL (the
    default) no legend will be drawn. The leg.pos should be specified as
    for \code{legend}, (eg. 'topright', 'bottomleft'). The column names of
    cex.data will be used for the legend text.}
  \item{bg.alpha, bg.sat, bg.val}{Parameters specifying the background
    colours for the plotStress functions. These colours are used to
    visualise the change in dimensionality through the mapping process.}
  \item{lwd, lty}{The width and type of line used to plot stress levels
    in plotStress}
  \item{main}{The title for the plot produced by plotStress. Defaults
    to "Error / Dimension"}
  \item{xlab}{The label of the x-axis. Defaults to NA for point plots.}
  \item{ylab}{The label of the y-axis. Defaults to NA for point plots.}
  \item{...}{Optional parameters passed to the plot function.}
}

\value{
  Does not return anything.
}

\seealso{
  \code{\link{SOD-package}}\cr
  \code{\link{DimSqueezer}}\cr 
  \code{\link{DimSqueezer_CL}} 
}

\examples{
\dontrun{
## construct a DimSqueezer object and squeeze
data(f186)
ds <- DimSqueezer(as.matrix(f186[,7:12]))

## squeeze to 2 dimensions
sq <- ds$squeeze(2, 1000)

## plot simple points coloured by the amount of stress
plotPoints(sq)

## with filled circles
plotPoints(sq, pch=19)

## coloured by one of the mapping parameters
plotPoints(sq, pch=19, col=hsvScale(f186[,'Etv2']) )

## this can also be done via the generic function:
plot(sq, ptype='p', pch=19, col=hsvScale(f186[,'Etv2']) )

## plot the dimensinonality and stress evolution
plotStress(sq)

## alternatively
plot(sq, ptype='s')

## plot concentric circles
plotConcentric(sq, cex.data=f186[,7:12], leg.pos='topleft')

## or as
plot(sq, ptype='c', cex.data=f186[,7:12])
}
}
