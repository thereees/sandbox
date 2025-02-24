days = seq(from = 1, to = 260)
type = c(1,2)
homeWork = rnorm(260, mean=10, sd=1.5)
workHome = rnorm(260, mean=10, sd=2.0)

consumption = data.frame(days, type, consumption = c(homeWork, workHome))
#write.csv(file="consumption.csv", x=consumption)

consumption = read.csv("consumption.csv")

homeWork = consumption[consumption$type == 1,]
workHome = consumption[consumption$type == 2,]

png(filename="homeWork.plot.png")
  plot(homeWork$day, homeWork$consumption)
dev.off()

png(filename="homeWork.hist.png")
  hist(homeWork$consumption)
dev.off()

png(filename="workHome.plot.png")
  plot(workHome$day, workHome$consumption)
dev.off()

png(filename="workHome.hist.png")
  hist(workHome$consumption)
dev.off()

normal.lik<-function(mu,sigma,y){
  sigma <- max(sigma, 0.0001)
  n<-length(y)
  logl <- sum(log(dnorm(y, mean = mu, sd = sigma)))/n
  return(-logl)
}
normal.lik.muvar <- function (theta,y){
  normal.lik(theta[1],theta[2],y)
}
v.normal.lik <- function (mu, sigma, y){
  mapply(function(m,s) normal.lik(m,s,y), mu, sigma)
}

library(RColorBrewer)
plotMLE <- function(data, x, y, steps = 20, levels = 10000) {
  x = seq(x[1], x[2], length= 20)
  y = seq(y[1], y[2], length= 20)
  f = function(x, y) {
    v.normal.lik(x,y,data)
  }
  z = outer(x, y, f)
  z[is.na(z)] = 0
  contour(x,y,z,col=rev(brewer.pal(11, "RdYlBu")), nlevels = levels,
    xlab="mean", ylab="standard deviation")
}

png(filename="homeWork.likelihood.png")
  plotMLE(homeWork$consumption, x=c(5,15),y=c(0,5), levels = 2000)
dev.off()
optim(c(12,4),normal.lik.muvar,y=homeWork$consumption,method="BFGS") 
png(filename="homeWork.likelihood.withlines.png")
  plotMLE(homeWork$consumption, x=c(5,15),y=c(0,5), levels = 2000)
  abline(h=1.70105, lty=2)
  abline(v=10.01983, lty=2)
dev.off()

plotGaussian <- function(start = -1, end = 1, u, sigma, scale, color = "black"){
  x <- seq(start, end, length=100)
  hx <- dnorm(x, mean = u, sd = sigma)*scale
  lines(x, hx, type="l", lty=2, xlab="x value", ylab="Density", main="Gaussian", col = color)
}
plotArea <- function(u, sigma, sigmaSize, color){
  x <- seq(-4, 4, length=100)
  hx <- dnorm(x, mean = u, sd = sigma)
  l <- -(sigma*sigmaSize)
  r <- (sigma*sigmaSize)
  i <- x >= l & x <= r
  polygon(c(l,x[i],r), c(0,hx[i],0), col=color)
}

png(filename="homeWork.hist.model.png")
  plot.new()
  hist(homeWork$consumption)
  plotGaussian(5, 15, 10, 1.7, 250, "red")
dev.off()

#WORK HOME

png(filename="workHome.likelihood.png")
  plotMLE(workHome$consumption, x=c(5,15),y=c(0,5), levels = 2000)
dev.off()
optim(c(12,4),normal.lik.muvar,y=workHome$consumption,method="BFGS") 
png(filename="workHome.likelihood.withlines.png")
  plotMLE(workHome$consumption, x=c(5,15),y=c(0,5), levels = 2000)
  abline(h=1.7274, lty=2)
  abline(v=9.87, lty=2)
dev.off()

# DAILY

days = seq(from = 1, to = 260)
daily = homeWork$consumption + workHome$consumption
consumption = data.frame(days, consumption = daily)
png(filename="daily.plot.png")
  plot(consumption$day, consumption$consumption)
dev.off()

optim(c(12,4),normal.lik.muvar,y=consumption$consumption,method="BFGS") 

png(filename="daily.hist.png")
plot.new()
  hist(consumption$consumption)
  plotGaussian(10, 30, 19.899697, 2.421108, 270, "red")
dev.off()

png(filename="daily.hist.png")
plot.new()
  hist(consumption$consumption)
  plotGaussian(10, 30, 19.899697, 2.421108, 270, "red")
  abline(v=25, lty=2, col ="green")
dev.off()

pnorm(25, mean = 19.899697, sd = 2.421108)
pnorm(25, mean = 19.899697, sd = 2.421108, lower.tail = FALSE)
