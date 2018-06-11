
data(iris)
str(iris)
table(iris$Species)
iris
set.seed(9850)
runif(5)
gp <- runif(nrow(iris))
gp
iris <- iris[order(gp),]
str(iris)
head(iris,10)
summary(iris[,c(1,2,3,4)])
normalize <- function(x) {
+return((x-min(x))/(max(x)-min(x)))
}
normalize(c(1,2,3,4,5))
normalize(c(10,20,30,40,50))
iris_n <- as.data.frame(lapply(iris[,c(1,2,3,4)],normalize))
str(iris_n)
summary(iris_n)
iris_train <- iris_n[1:49, ]
iris_test <- iris_n[50:150, ]
iris_train_target <- iris[1:49,5]
iris_test_target <- iris[50:150,5]
require(class)
m1 <- knn(train=iris_train, test=iris_test, cl=iris_train_target, k=13)
m1
table(iris_test_target, m1)
