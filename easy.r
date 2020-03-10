#The following calculates the volume of a random 3-dimensional polytope with 50
#facets:

> library(volesti)
> volume(GenRandHpoly(3,50))
[1] 4810.283

#As GenRandHpoly creates a polytope P by randomly choosing hyperplanes tangent to
#the sphere S of radius 10 centered at the origin, it is always the case that P
#contains S. As we increase the number of facets, the volume of P should converge
#(from above) to the volume of S, which is 4\pi/3 * 10^3 ~ 4188.79.

#The following lines compute the mean volume of 10 3-dimensional random polytopes
#with n facets, for n=50, 100, 500, 1000 and 2000:

> mean(sapply(sapply(rep(50,10), GenRandHpoly, dimension=3),volume))
[1] 4810.201
> mean(sapply(sapply(rep(100,10), GenRandHpoly, dimension=3),volume))
[1] 4452.587
> mean(sapply(sapply(rep(500,10), GenRandHpoly, dimension=3),volume))
[1] 4237.602
> mean(sapply(sapply(rep(1000,10), GenRandHpoly, dimension=3),volume))
[1] 4214.393
> mean(sapply(sapply(rep(2000,10), GenRandHpoly, dimension=3),volume))
[1] 4200.588
