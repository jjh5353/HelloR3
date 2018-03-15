#dataManage2
#학생 성적 데이터에 대해 학점을 부여
#3과목 점수가 일정하지 않음 - 평균, 편차 구하기가 어려움 
#학점을 구하려면 백분위를 결정
#이름으로 정렬하기어려움 - 성과 이름 분리 

#수학함수
data<-c(2, 7.1, -5.5, 1.9, -4.2, 6, 9)
data<-seq(-3,3,0.5)

ceiling(data) #무조건 올림
floor(data)   #무조건 내림
round(data)   #반올림 round(값, 숫자) (추천!)
trunc(data)   #절삭
signif(data)  #반올림
abs(data)     #절대값
sqrt(data)    #제곱근

sort(data)    #정렬
rev(data)     #역순
rank(data)    #순위
cumsum(data)  #누적합
cumprod(data) #누적곱
cummax(data)  #누적 최대값
cummin(data)  #누적 최소값

#통계함수
data<-c(2,7,5,3,1,4,6)

sum(data)
prod(data)   #원소를 모두 곱한 것 
max(data)
min(data) 
diff(data)       #차분
which.max(data)  #최대값의 index 
which.min(data)  #최소값의 index
range(data)      #범위

mean(data)       #평균
median(data)     #중간값
sd(data)         #표준편차
var(data)        #분산
quantile(data)   #중위값

#확률함수: runif() - 0~1사이의 균등분포 난수 생성
#set.seed(nnn) 난수생성 seed 설정 
set.seed(999) 
runif(10) 

#문자함수
#nrow, ncol
ch<-c('ab','xyz','abc123')
nchar(ch)  #문자수를 센다

ch<-'abc123xyz987'
substr(ch,2,4) #지정한 위치의 문자를 추출 

grep('xyz', ch, fixed=T) #지정한 패턴에 의해 문자검색
x<-c('abc','123','xyz','987')
grep('xyz',x,fixed=T)

sub() #패턴에 의해 지정한 문자를 검색하고 문자치환
sub('\\s', '.','Hello, World!')   #공백->. 
sub('\\s', '.',' Hello, World!')
sub('\\s', '.','Hello,World!')

strsplit() #문자에서 특정 요소를 분리
c<-strsplit('abc123','b')
c
x

paste() #구분자로 문자열을 분리한 후 결합
paste('x', 1:3, sep='')
paste('x', 1:3, sep='M')
paste(1:3, c('엄마', '민지', '민재'), sep='와')
paste('오늘은',date())

toupper(ch) #대문자 변환
tolower(ch) #소문자 변환

mean_iris

iris[1:4]
scale(iris[1:4])

#성적처리
#성적처리 지표: ABCDF (20점씩 나누어서 점수 분배)
#성과 이름을 분리 
options(digits=2) #소수점 2자리
Student<-c('John Davis','Angela Williams','Bullwinkle Moose','David Jones',' Janice Markhammer','Cheryl Cushing','Reuven Ytzrhak','Greg Knox','Jeol England','Mary Rayburn')
Math<-c(502,600,412,358,495,512,410,625,573,522)
Science<-c(95,99,80,82,75,85,80,95,89,86)
English<-c(25,22,18,15,20,28,15,30,27,18)

roster <- data.frame(Student,Math,Science,English,
                     stringsAsFactors = F) #팩터로 생성되지 못하게 한다!  

#성적데이터를 표준화 시킴: scale
#이웃분류KNN, 벡터지원 SVM, 신경망 등 
#많은 분류 알고리즘에 유용하게 사용
#변수값을 적당한 수준으로 조정 : 0~1, -1~1
#조정된 값을 평균과 표준편차로 다시 재계산 
iris[1:4]
scale(iris[1:4])


#성적데이터 표준화
newdata<-scale(roster[,2:4])
newdata

#평균점수 구하기
mean(newdata)   #결과가 제대로 안나옴 

#apply 함수 이용
#특정연산을 손쉽게 처리하게 해주는 함수 
score<-apply(newdata, 1, mean)  #행단위 연산
iris[1:4]
apply(iris[1:4],1,mean)
apply(iris[1:4],2,mean)         #열단위 연산

apply(iris[1:4],1,function(x){x+100})


apply(Fruits[4:6],1,mean)
apply(Fruits[4:6],2,mean)

#구해진 평균점수를 roster테이블에 열로 추가 
roster <- cbind(roster,score)
roster
newdata
score


#newdata에서 학생별 최대점수, 최소점수를 출력해서 
#maxscore, minscore 이름으로 열을 추가
min(newdata)
max(newdata)
newdata<-rename(newdata,c(newDate='maxscore',country='minscore'))



#newdata에서 과목별 최대점수, 최소점수를 출력해서 
#maxmath, maxsci, maxeng 이름으로 열을 추가
#minmath, minsci, mineng
max <-apply(newdata[,1:3],2,max)
min <-apply(newdata[,1:3],2,min)
max
min

max <-apply(roster[,2:4],2,max)
min <-apply(roster[,2:4],2,min)
max
min

#학점 계산 - 사분위수
#quantile() - 집단에서 측정된 수치의 특성을 표현
#분위수 - 확률적으로 균등하게 영역을 나눠 계산한 수
y<-quantile(score,c(.8,.6,.4,.2))
y
roster

roster$grade[score>=y[1]]<-'A' 
    #상위 80%에 속하는 사람들:자신의 점수가 0.74 이상 
roster$grade[score<y[1] & score>=y[2]]<-'B'
    #상위 79~60%에 속하는 사람들: 자신의 점수가 0.44 이상 
roster$grade[score<y[2] & score>=y[3]]<-'C'
    #상위 59~%에 속하는 사람들: 자신의 점수가 0.44 이상 
roster$grade[score<y[3] & score>=y[4]]<-'D'
    #상위 79~60%에 속하는 사람들: 자신의 점수가 0.44 이상 
roster$grade[score<y[4]]<-'F'
score
roster


#이름에서 성과 이름 분리:strsplit
strsplit(roster$Student, '')  #글자 한자씩 분리 sep=''
strsplit(roster$Student, ' ') #공백으로 분리 sep=' '

name<-c('a 1','b 2')
names<-strsplit(name, ' ')
names
names <- strsplit(name, '')
names
names[[1]][1]
names[[1]][2]

apply(names,1,'[')
sapply(names,"[",1)

#names에 있는 모든 원소에 대해 행단위로 원소추출 함수([]) 적용
#첫번째 원소 목록 출력

names <- strsplit(roster$Student,' ')
lname <- sapply(names,'[',1)
lname
fname <- sapply(names,'[',2)
fname
#roster <-cbind(fname,lname)
roster <-cbind(fname,lname,roster[,-1])
      #이름과 성을 각각 조합하고,
      #기존 데이터프레임에서 첫번째 열을 제외한뒤
      #나머지를 여기에 각각 열로 추가한다 
roster

roster<-roster[order(lname,fname),]
roster<-roster[order(fname,lname),]

#apply : apply(대상, 행/열, 함수)
#배열, 행렬에 함수를 행이나 열로 방향을 적용
#결과는 벡터, 행렬, 리스트로 출력 (범용으로 사용)
#sapply : apply나 lapply를 사용하기 편하게 간편화 시킴 
#
#lapply :

sum(1:20) #1~20까지의 합 - 벡터, 1차원배열
nums<-matrix(1:20, ncol=4) #2차원 배열
apply(nums, 1, sum)  #행 단위로 sum 적용
apply(nums, 2, sum)  #열 단위로 sum 적용

iris[1:4]
class(iris[1:4])
iris[,1:4]
class(iris[,1:4])

#apply(iris[, 1:4],mean)
apply(iris[, 1:4],1,mean)  #결과가 벡터 (행)
apply(iris[, 1:4],2,mean)  #결과가 벡터 (열)
lapply(iris[, 1:4],mean)    #결과는 리스트 (열)
sapply(iris[, 1:4],mean)   #결과는 벡터 (열)

#실행흐름 제어: if, for, switch
#반복문- 자주 사용하지 X: apply ㅎ삼수 이용
for(i in 1:10){
  print(i)
  result<-i*3
  print(result)
}

i<-1
while(i<=10){
  print(i)
  i<-i+1
}

i<-1
while(T){
  i<-i*3
  print(i)
  if(i>99999) break
}


i<-1
repeat{                 #do-while 구문과 유사 
  result<-i*3
  print(result)
  if(i>999) break  
  i<-i+1
}


#조건문 - if 
grade<-'수'
if(is.character(grade)) {grade<-as.factor(grade)}
if(!is.factor(grade)){grade<-as.factor(grade)
} else{print('이미 factor형으로 선언된 변수입니다!')}

#ifelse(조건, 문장1, 문장2)
i <- 1
ifelse((i>10),'10보다 크다', '10보다 작다')

x<-c(6:-4)
sqrt(x) #경고 표시 - 음수는 제곱근 계산 불가!
sqrt(ifelse(x>=0, x, NA)) #경고는 표시x
options(digits=2) # 소수점 2자리

#switch: 
todayfeels <-c('sad','blue','happy','afraid')
for (i in todayfeels){
  print(
  switch(i,happy='행복',afraid='두려움',blue='우울',sad='슬픔')
  )
}

todayfeels <-c(1:4)
for (i in todayfeels){
  print(
    switch(i,print('행복'), print('두려움'), print('우울'), print('슬픔'))
  )
}

todayfeels <-c(1:4)
for (i in todayfeels){
  print(
    switch(i,'행복','두려움', '우울', '슬픔')
  )
}


#데이터 집계 - aggregate
#특정한 값을 기준으로 그룹화 한후 다양한 집계 처리 
#aggregate(계산될 열 ~ 기준될열, 데이터, 함수)

library(googleVis)
Fruits #과일, 년도, 위치, 판매액, 비용, 이익, 날짜
#Fruit,Year,Location,Sales,Expense,Profit,Date

#년도별 총 판매액
aggregate(Sales~Year, Fruits, sum)

#과일별 총판매액
aggregate(Sales~Fruit,Fruits,sum)

#과일별 최고판매액
aggregate(Sales~Fruit,Fruits,max)

#과일별 최저판매액
aggregate(Sales~Fruit,Fruits,min)

#과일별, 연도별 최저판매액 
aggregate(Sales~Fruit+Year,Fruits,min)

#iris 데이터집합에서 종별 꽃받침의 평균 길이는? Sepal.Length, Species
aggregate(Sepal.Length~Species,iris,mean)
aggregate(Sepal.Length~Species,iris,max)
aggregate(Sepal.Length~Species,iris,min)
iris

#iris 데이터집합에서 종별 꽃잎의 평균 길이는? Petal.Length,Species
aggregate(Petal.Length~Species,iris,mean)
aggregate(Petal.Length~Species,iris,max)
aggregate(Petal.Length~Species,iris,min)

#차종별 도시MPG.city 와 고속도로의MPG.highway 평균 연비 계산
install.packages('MASS')
library('MASS')
str(Cars93)

#MPG.city ,MPG.highway
attach(Cars93)
data.frame(MPG.city,MPG.highway,Type)
detach(Cars93)

aggregate(MPG.city~Type,Cars93,mean)
aggregate(MPG.highway~Type,Cars93,mean)


aggregate(MPG.city~Type,Cars93,max)
aggregate(MPG.highway~Type,Cars93,max)


#tapply : 그룹별로 함수를 적용하는 apply 계열 함수
x <-c(1:20)
y <-rep(c(1,2,3,4),5) #1,2,3,4 를 5번씩 반복
y

#1 2 3 4 5 6 7 8 9 10 ...
#1 2 3 4 1 2 3 4 1 2 ...
tapply(x,y,sum)

tapply(x,x%%2==0,sum) #짝수/홀수의 합 계산

#iris에서 종별 꽃받침
tapply(iris$Sepal.Width, iris$Sepices,mean)

#Fruits 데이터 집합에서 연도별 총 매출액
tapply(Fruits$Sales, Fruits$Year,sum)

#데이터재구성 reshape
#데이터를 좀 더 향상된 방식으로 자르고 붙이는 기능 제공
#wide-format data : 데이터 분석시 많이 이용
#long-format data : 다양한 상황에 사용 

#melt : 기존 데이터를 long-format data로 변형
#cast : 기존 데이터를 wide-format data로 변형

#이처럼 데이터구조를 바꾸려면
#reshape2패키지를 설치하고
#melt, cast 함수를 사용하면 된다
install.packages('reshape2')
library(reshape2)

airquality #대기질에 관련된 데이터 집합
str(airquality)

#melt : 특정컬럼을 기준으로 variable , value로 나눔
#데이터 프레임을 다룰때 데이터 구조를
#행의 키를 기준으로 나머지를 변수화해서
#하나의 열에 담아버리는 것을 melt, melting 이라함
#melt(데이터, 기준열)
head(airquality)
air1 <- melt(airquality,id.vars=c('Month','Day'))
head(air1)
#'Month','Day'를 기준으로 나머지는 변수명 컬럼,값 컬럼에 모두합쳐 저장함

air2<-melt(airquality, id=c('Month','Day'),measure=c('Solar.R','Wind'))
#'Month','Day'를 기준으로 'Solar.R','Wind'를
#' 변수명 컬럼,값 컬럼에 모두합쳐 저장함


#mydata 생성하기
ID <-c(1,1,2,2)
Time <-c(1,2,1,2)
X1<-c(5,3,6,2)
X2<-c(6,5,1,4)
original<-data.frame(ID,Time,X1,X2)
melted<-melt(original,Id=c('ID','Time'))
#ID,Time은 남겨주고 나머지는 변수명, 값 열에 

head(original)
head(melted)

#Fruits데이터를 year를 기준으로 
#나머지 데이터를 melt하세요
Fruits
yfruits <- melt(Fruits,id='Year')
yfruits <- melt(Fruits, id='Year',variable.name = 'fruits_type',value.name = 'qty_price')
yfruits

#melt 된 데이터를 새로운 형식의 데이터로 만들려면
#집계함수가 적용된/적용되지않은 dcast 함수를 이
#dcast (데이터, 기준컬럼~재상컬럼,적용함수)
melted
dcast(melted,ID~variable,mean)
#ID를 기준으로 variable 컬럼의 모든 데이터를 그룹화해서 평균을 계산
#모든데이터를 그룹화해서 평균을 계산
dcast(melted, ID~variable) #ID,X1,X2
dcast(melted, ID+Time~variable) #ID,Time,X1,X2
dcast(melted, ID+variable~Time) #ID,variable,Time1,Time2
dcast(melted,ID~variable+Time) #ID, X1_TIME1,X1_TIME2,X2_TIME1,X2_TIME2

yfruits <- melt(Fruits, id='Year', variable.name = 'fruits_type',value.name='qty_price')
dcast(yfruits,Year~fruits_type)

#Fruits 데이터를 year,fruits를 기준으로 
#sales,expense,profit 데이터를 melt 하세요

f<-melt(Fruits,id=c('Year','Fruit'),
        measure=c('Sales','Expenses','Profit'))
dcast(f,Year~variable)
dcast(f,Fruit~variable)
dcast(f,Year+Fruit~variable)
dcast(f,Year+Fruit~variable,sum)
dcast(f,Year~Fruit+variable)

subset(test,학과 =='경영학과')

#R를 사용하기 편리하게 해주는 패키지
install.packages("rattle")
library(rattle)


