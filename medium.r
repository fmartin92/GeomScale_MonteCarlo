#The following calculates the value of the integral in a 3-dimensional cube, for
#a=1:

> library(cubature)
> a <- 1
> squared_vector_norm <- function(x) {sum(x^2)}
> f <- function(x) {exp(-a*squared_vector_norm(x))}
> erf_integral <- function(n) {cubintegrate(f, rep(-1, n), rep(1,n))$integral}
> erf_integral(3)
[1] 3.332308

#The exact value of the integral of f(x) = e^(-a \vert x \vert^2) is
#(\sqrt{\pi/a} erf(\sqrt{a}))^n. For fixed n, this approaches 2^n when a
#approaches zero from above. For small values of a, performance is really good:

> a <- 1/10000
> for(n in (1:6)) {print(erf_integral(n))}
[1] 1.999933
[1] 3.999733
[1] 7.9992
[1] 15.99787
[1] 31.99467
[1] 63.9872

#As a and n grow, performance worsens. For a=1, the following executes in just
#under a minute on my modestly powered desktop computer:

> a <- 1
> for(n in (1:6)) {print(erf_integral(n))}
[1] 1.493648
[1] 2.230986
[1] 3.332308
[1] 4.977295
[1] 7.434328
[1] 11.10427

#Note that the actual value of the integral from n=1, a=1 is around 1.49365 --
#the rest of the values are just consecutive powers of this number.
#As we see, precision also worsens (both absolute and relatively) as n increases.
