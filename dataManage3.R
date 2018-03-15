#dataManage3

#결측치 - NA, 99999,unknown, not answer 
#누락된 값, 비어있는 값 - 함수 적용 불가, 분석결과 왜곡
#제거 또는 대체후 분석 실시 

gender<-c('남','여','남','남','여')
score<- c(5,3,2,NA,4)
df<-data.frame(gender,score)
df
#결측치 확인
is.na(df)

#결측치 빈도 확인
table(is.na(df))
df[3,1]<-'NA' # (3,1)에다가 NA를 넣어준다 
table(is.na(df))
df
table(is.na(df$gender))  #성별에서 결측치 측정 

#평균계산 - 결측치NA 포함 상태
mean(df$score)     #NA로 출력
sum(df$score)

#결측치 처리
mean(df$score, na.rm=T)
sum(df$score, na.rm=T)

#결측치 처리 - na.omit()
odf<-na.omit(df)
odf
mean(odf$score)
sum(odf$score)

#MASS 라이브러리의 Cars93 데이터 집합에서
#결측값이 모두 몇개인지 확인

install.packages('MASS')
library('MASS')
str(Cars93)
is.na(Cars93)
table(is.na(Cars93))


#결측치 확인 - 관측치에 결측값이 있는지 여부 검사 
#데이터 프레임의 각 행에 대해 결측치를 확인 
#행에 저장된 값이 모두 결측치가 아닌 경우에만 TRUE 반환 
complete.cases(Cars93)
table(complete.cases(Cars93))
Cars93[!complete.cases(Cars93), ]

#is.na vs complete.cases
#is.na는 컬럼에 대해 NA 여부 확인 
#complete.cases는 행에 대해 NA 여부 확인 

#rkseksgks dPwp
iris_na<-iris
iris_na [c(10,20,25,40,32),3] <-NA
iris_na[c(33,100,125),1]<-NA
iris

# is.na 결과는?
str(iris_na)
is.na(iris_na)
table(is.na(iris_na))

# complete.cases 결과는? 
complete.cases(iris_na)
table(complete.cases(iris_na))
iris_na[!complete.cases(iris_na), ]


#결측값 처리 
#결측값이 있는 행을 제거
#평균값 또는 임의의 값으로 대체 
#R에서는 DMwR 패키지를 이용해서 중앙값으로 대체 
#R에서는 DMwR 패키지의 이용해서 KNN 알고리즘 이용해서 가중평균치로 대체 
gender<-c('남','여','남','남','여')
score<- c(5,3,2,NA,4)
df<-data.frame(gender,score)
df[3,1]<-'NA'

#임의의 값으로 대체
df
odf<-df
odf
odf$score[is.na(odf$score)]<-0


#평균값
odf<-df
odf
omean<-mean(odf$score, na.rm = TRUE) #NA를 제외한 평균 계산 
odf$score<-ifelse(is.na(odf$score),omean,odf$score)
  #참이면 앞에것을 넣고 거짓이면 odf$score을 넣고 
  #NA항목에 평균 대체
odf

#iris로 해보기
oiris<-iris
oiris
oiris$Sepal.Length[is.na(oiris$Sepal.Length)]<-0
oiris

oirismean<-mean(oiris$Sepal.Length, na.rm=TRUE) 
oiris$Sepal.Length<-ifelse(is.na(oiris$Sepal.Length),oirismean,oiris$Sepal.Length)
oiris
is.na(oiris)
table(is.na(oiris))
iris

#결측치 처리 

#DMwR 패키지 - 중앙값 대체
iris_na<-iris
iris_na
iris_na [c(10,20,25,40,32),3] <-NA
iris_na[c(33,100,125),1]<-NA
iris_na[1:4]
mapply(median,iris_na[1:4], na.rm=TRUE) #열에 따라서 중앙값을 출력 
#위에서 구한 중앙값을 NA가 위치한 곳에 대체 - 불편
install.packages("DMwR")
library(DMwR)
iris_na<-centralImputation(iris_na[1:4])[c(10,20,25,40,32,33,100,125),]
          #행단위로 데이터를 찾아서 넣는것임
iris_na[1:4]

#DMwR 패키지 - KNN알고리즘 가중평균치 대체
iris_na<-iris
iris_na [c(10,20,25,40,32),3] <-NA
iris_na[c(33,100,125),1]<-NA
iris_na[1:4]
knnImputation(iris_na[1:4])[c(10,20,25,40,32,33,100,125),]
          #행단위로 데이터를 찾아서 넣는것임
knnImputation(df2,k=5,meth=median,prob=TRUE)


#이상치
#정상기준에서 벗어나면 결측 처리
#논리적 판단 : 나이가 150을 넘어서면 (이상)극단치 
#             국어점수가 100을 넘어서면 극단치
#통계적 판단 : 평균으로부터 3표준편차 떨어진 값
#             사분위수에서 하단/상단 경계값을 벗어난 값

age<-c(10,23,33,999,121)
score<-c(50,75,88,200,150)
name<-c('a','b','c','d','e')
df2<-data.frame(name,age,score)
df2

#이상치 판단-NA대체 -> 결측치 처리
df2$age<-ifelse(df2$age > 100 | df2$age< 0, NA, df2$age)
df2$score<-ifelse(df2$score>100,NA,df2$score)
df2

#논리적 판단에 의해 이상치들은 NA로 대체
!complete.cases(df2[2:3])
df2_na<-centralImputation(df2)[
        !complete.cases(df2),]    
df2
#NA 결측치들은 평균값으로 대체

df2_na<-centralImputation(df2)[
        !complete.cases(df2),] 

#데이터가 소량이라 경고 발생!!


df2 <-rbind(na.omit(df2),df2_na)
df2
#기존 NA 결측치는 제거하고, 평균값으로 대체 된 행과 합침  

#KNN 알고리즘 이용해서 가중 평균치로 대체 
age<-c(10,23,33,999,121)
score<-c(50,75,88,200,150)
name<-c('a','b','c','d','e')
df2<-data.frame(name,age,score)
df2
df2$age<-ifelse(df2$age > 100 | df2$age< 0, NA, df2$age)
df2$score<-ifelse(df2$score>100,NA,df2$score)
df2

knnImputation(df2_na[1:3])[c(4,5),]



#mpg 데이터집합에서 drv(차량종류)에 
#이상치가 있는지 알아보고 적절하게 수정하세요
#결측처리시 %in% 연산자를 사용하세요
#%in% c('f','r','4') mpgdrv가 f이거나r이거나4이거나
#drv : r(후륜구동), f(전륜구동), 4(4륜구동)
install.packages('ggplot2')
library(ggplot2)
mpg #1999년 부터 2008년 까지 38 인기차종에 대한 연비 통계 
mpgdrv<-mpg$drv
table(mpg$drv) #이상치 여부 확인 
mpgdrv<-ifelse(mpgdrv %in% c('f','r','4'),mpgdrv,NA)
        #mpgdrv가 f이거나r이거나4이거나 확인함
mpgdrv
mpgdrv_na<-knnImputation(mpgdrv)[!complete.cases(mpgdrv),]
              #가중 평균치로 대체 
mpgdrv<-rbind(na.omit(mpgdrv),mpgdrv_na)



















