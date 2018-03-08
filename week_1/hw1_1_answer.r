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
    if (year%%4==0 && year%%100!=0 || year%%400==0){
        print("閏年")
        return TRUE
    }
    else{
        print("非閏年")
        return FALSE
    }
}

### Task5 ###
ans <- sample(0:9, 4)
guess.count <- 0

repeat {
  print("Please input 4 non-repetitive numbers.[integers between 0 to 9, aka c(0:9)")
  guess <- scan(nmax = 4)
  
  a <- b <- 0
  
  if (!any(duplicated(guess))){
    guess.count <- guess.count + 1
    
    for (i in 1:4) {
      if (guess[i] == ans[i]) {
        a <- a + 1
      } else {
        for (j in 1:4) {
          if (guess[i] == ans[j]) {
            b <- b + 1
          }
        }
      }
    }
    
    cat("==== Your guess :", guess, ", Match : ", a, "A", b, "B\n")

    if (a == 4) {
      cat("==== CORRECT! You guess for", guess.count, "times")
      break
    }
    
  } else {
    cat("==== Input Error: Please input 4 <non-repetitive> numbers.\n")
  }
}