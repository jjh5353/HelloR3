#R 기본사용법

#ctrl + L 콘솔 내용 모두삭제

#설치후 간단 테스트
print('Hello, R!!!')
print('안녕~R!!')
+
  ctrl + enter

주석처리 - ctrl + shift + c

#R 한국어도움말 사이트
https://homepage.usask.ca/~chl948/doc/manual/R-intro-ko.html

#간단한 실행테스트
#주석삽입은 ctrl + shift + c
#한줄 실행은 ctrl + enter
print('Hello,R!!')
print('안녕,R3!!')

#여러줄에 걸쳐 입력하기
print(
  "Hello, R, again!!"
)

#Sample R script
#나이와 몸무게의 상관관계 파악
age <- c (1,3,5,2,11,9,3,9,12,3) 
#벡터형식으로 데이터 정의하고 변수 age에 대입
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)

age   #입력된 값 확인 
weight

mean(weight) #산술평균
sd(weight) #표준편차 (평균에서 얼마나 떨어져 있나?)
cor(age, weight) #상관계수
#두 사건간의 연관성(관계)조사 : 
#두 변수간의 선형적 관계 파악 
#예) GDP와 기대수명, 키와 몸무게간 관계

plot(age, weight) #그래프 작성

#간단한 그래프 데모 
demo() #데모 가능 목록 출력
demo('graphics') #그래프데모 시연

#도움말 함수
help.start()

help('q') #q()에 대한 도움말출력
?q   #q()에 대한 도움말 출력2

q()# R 종료

help.search('q') #특정단어를 포함하는 도움말 검색
RSiteSearch('q') #온라인 상에서 도움말 검색
apropos('q',mode='function') #특정 단어가 포함된 함수를 찾아줌

data() #현재 설치된 패키지 상의 이용가능한 모든 자료집합을 나열
vignette() #이용가능한 모든 소품문을 나열(패키지에 대한 장문 안내서)

example('c')

#작업공간 관련함수
getwd() #현재 작업 디렉토리 출력
setwd("c:/java") # 새로운작업 디렉토리를 설정

ls() #현재 작업공간의 모든 객체를 출력
rm() #하나이상의 객체를 제거
rm(age)
rm(weight)
ls()

option() #현재 작업공간에서 사용가능한 설정에 대한 정보 제공
history() #명령어 목록출력
history(5) #끝에서 n개의 명령어 출력
savehistory('c:/JAVA/.Rhistory') #명령어 히스토리를 저장(.Rhistory)
loadhistry('파일명') #명령어 히스토리를 불려서 메모리에 적재 

save(age, file='c:/JAVA/age.data') #특정객체를 파일에 저장
load('c:/JAVA/age.data') #파일을 작업공간으로 읽어들임

setwd('c:/JAVA')
dir.create('xyz') #특정 디렉토리 생성

#sample R script 2
setwd('c:/JAVA/xyz')
options('digits') #소수점 출력 자릿수
options(digits=3)
options('digits')
x <- runif(20) #20개의 임의의 난수 생성
x
summary(x) #기본적인 통계 정보 출력
# 최대 /최소 , 평균 , 중간값median, 최빈값 mode
# 하한 사분위값 (데이터의 25%가 이 값보다 작거나 같음)
# 상한 사분위값 (데이터의 75%가 이 값보다 크거나 같음)
hist(x)    # 히스토 그램(막대그래프) 출력

#패키지-일정 규칙에 따라 누구나 제작하고
#배포가능하다는 장점때문에 R에는 수천가지의
#다양한 패키지 제공

.libPaths()#패키지 설치정보확인
installed.packages() #설치되어 있는 패키지 확인
library(help='datasets') #특정 패키지에 대한 정보 확인

#datasets 패키지의 HairEyeColor 자료를 사용하려면?
library('datasets')	#특정 패키지를 메모리에 올림
HairEyeColor

install.package('패키지명') #특정 패키지를 설치 
install.packages('rJava')
update.packages() #패키지 업데이트 하기

remove.packages('패키지명') #특정 패키지를 제거
remove.packages('rJava')

#패키지 설치는 단 한번만 실행
#라이브러리 적재는 매번 실행해야 한다

#한편, 특정함수를 실행할때, library 명령없이
#사용가능한 함수들이 있음 - base system 패키지

#도움말을 열어 'introduction R'을 열어보자
help('introduction R')

#vcd패키지를 설치하라
install.packages('vcd')

#이 패키지에서 이용가능한 함수와 데이터집합을 살펴보라
library(help='vcd')

#이 패키지를 적재하고 Arthritis 데이터집합을 살펴보라
library('vcd')
help('Arthritis')

#Arthritis 데이터집합을 출력하라
Arthritis

#Arthritis 예제를 실행하라
example('Arthritis')


