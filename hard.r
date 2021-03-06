#The nCube function creates the n-dimensional cube as an H-polytope. This is
#preferable than describing it as a V-polytope, since the number of vertices
#grows exponentially on n, while the number of facets grows linearly.

> library(volesti)
> nCubeMatrixColumn <- function(n,i) {c(rep(0,2*i), 1, -1, rep(0,2*(n-i-1)))}
> nCubeMatrix <- function(k) {sapply(0:(k-1), nCubeMatrixColumn, n=k)}
> nCubeVector <- function(k) {rep(1,2*k)}
> nCube <- function(k) {Hpolytope$new(nCubeMatrix(k), nCubeVector(k))}

#The following is a simple Monte Carlo method for integrating the function f over
#the polytope p, sampling n different points according to the distribution
#parameter, which can be either 'uniform' or 'gaussian':

> montecarlo <- function(p, f, n, distrib) {
+     sum(apply(sample_points(p, n, distribution=distrib), 2, f))*volume(p)/n}

#As in the medium difficulty test, let us integrate the function f with a=1/10000
#and, for instance, n=6. Values should then be close to 2^6=64.

> integrals <- sapply(rep(1000, 30), montecarlo, p=nCube(6), f=f, dist='uniform')
> integrals
[1] 65.16289 62.54934 60.57801 64.12172 61.98276 63.78349 63.20685 62.78717
[9] 60.84492 61.14587 64.24831 60.17750 63.95499 65.29688 63.12109 63.53377
[17] 61.50121 65.58054 63.46086 65.17576 62.67733 63.91957 65.77359 64.19913
[25] 60.28716 59.93406 64.84394 62.26665 62.25638 63.75118
> mean(integrals)
[1] 63.07076
> sd(integrals)
[1] 1.696173

#There is, as expected, a somewhat large variance, but the code executes in under
#1 second and it does not get considerably worse when a is large. The following
#calculates 10 montecarlo approximations to the integral over the 20-dimensional
#cube of f when a=5, using 1000 sample points, and runs in less than 10 seconds:

> integrals <- sapply(rep(1000, 10), montecarlo, p=nCube(20), f=f, dist='uniform')
> mean(integrals)
[1] 0.003152802
> sd(integrals)
[1] 0.002428066

#Note that the standard deviation is quite high compared to the mean value of the
#integrals. A similar thing happens when using the gaussian distribution:

> integrals <- sapply(rep(1000, 10), montecarlo, p=nCube(20), f=f, dist='gaussian')
> mean(integrals)
[1] 0.04613329
> sd(integrals)
[1] 0.06383225

#Over all the experiments I ran, the standard deviation seems to be smaller when
#using points sampled uniformly.
