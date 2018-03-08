### Task1 ###
iris
dim(iris)
head(iris)
tail(iris)
str(iris)
summary(iris)

### Task2 ###
for (i in c(1:9)){
    for (j in c(1:9)){
        print(paste(i, 'x', j, '=', i*j))
    }
}

### Task3 ###
nums <- sample(10:100, 10)
nums
for (n in nums){
    if (n == 66){
        print("太66666666666了")
        breal
    }
    else if ((n>50) && (n%%2==0)){
        print(paste("偶數且大於50：", num))
    }
}

### Task4 ###
isGapYear <- function(year){
    if (year%%==0 && year%%100!=0 || year%%400==0){
        print("閏年")
        return 1
    }
    else{
        print("非閏年")
        return 0
    }
}

### Task5 ###
ans <- sample(0:9, 4)
guess.count <- 0

repeat{
    print('Please input 4 numbers to quess:')
    guess <- scan(nmax=4)
    a <- b <- 0
    
}