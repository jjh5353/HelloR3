#회귀분석
#상관분석은 변수들이 서로 얼마나 밀접한 관계를 가지고 있는지 
#분석하는 통계적 기법

#한편, 회귀분석은 상관분석 + 예측하는 통계적 기법
#회귀분석시 변수는 한 개 이상일 수 있다
#각각의 변수들을 독립변수와 종속변수로 나누어 관계 파악

#예를 들어, 작년 여름에 온도가 30도 이상일때 
#빙과류가 하루 평균 100개 팔렸다
#올해 여름에도 온도가 30도 이상되면
#빙과류가 과연 30개 이상 팔릴까? - 회귀분석 

#영국 유전학자 골턴은 
#부모의 키와 자녀들의 키 사이의 연관관계 조사 -선형적 관계 있음을 파악  
#후에 칼 피어슨이 이것을 수학적으로 증명함 - 회귀분석 이론 정립  

#즉, 앞으로 발생할 일은 지난 과거에 일어난 일의 
#평균값 수준으로 돌아간다는 성질이 있음 

#따라서, 회귀분석은 시간에 변화하는 데이터나
#어떤 영향, 가설적 실험, 인과관계등의 모델링등의 
#통계적 예측에 사용될 수 있음 

#예를 들어, 어떤 회사가 광고를 5번 했을때 판매량은 얼마나 될까?를
#조사한다고 할때 회귀분석을 이용하면 된다
#산포도에서 일정한 점들이 모여있는 패턴을 파악하고
#공식으로 도출해 낸다면 판매량을 예측할 수 있다
#공식을 도출해서 y= 50+30x가 나왔다면
#x=5를 적용하면 y(판매량)은 200이 된다

#이렇게 점들이 퍼져있는 형태에서 일정한 패턴을 찾고
#이 패턴을 통해 무언가를 예측하는 것이 회귀분석이다 

#회귀분석에는 선형회귀분석과 로지스틱 회귀분석이 있음 

#종속변수에 영향을 주는 변수가 1개 - 단일회귀 1차방정식
#2개 이상 - 다중회귀 2차방정식
#확률 계산 - 로지스틱 회귀

#부모와 자식의 IQ관계 파악
#부모의 IQ가 117이라면 자식의 IQ는 얼마일까?
#부모:110,120,130,140,150
#자식:100,105,128,115,142
p<-c(110,120,130,140,150)
c<-c(100,105,128,115,142)

plot(p,c,pch=20,col='red')
pc_iq<-lm(c~p)  
 # y=-4.20+o.94x  #p가x값이고 나온숫자는 변량임

abline(lm(c~p),col='blue') #추세선

#회귀모형 검증 및 적합도 파악
#lm() 함수로 구한 회귀식이 통계적으로 유의 여부 확인
#어느정도 설명 가능한지 여부 확
#F통계량 

#p-value : p-value: 0.05764 통계적으로 의미 없다 

#R제곱:통계 설명 가능 여부 
#Adjusted R-squared:  0.6668 (약67%) 
##모형이 75%로 잘 설명되고 있다는 뜻 
#통계설명가능- 예측값을 믿을 수 있는 정도 

summary(pc_iq) 


#한꺼번에 주석처리는 ctrl+shift+c

# Call:
#   lm(formula = c ~ p)
# 
# Coefficients:
#   (Intercept)            p  
# -4.20         0.94  
# 
# lm(formula = c ~ p)
# 
# Residuals:
#   1     2     3     4     5 
# 0.8  -3.6  10.0 -12.4   5.2 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)  
# (Intercept)  -4.2000    40.9644  -0.103   0.9248  
# p             0.9400     0.3133   3.001   0.0576 .
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# *이 많을수록 의미가 있다는 뜻임 

# Residual standard error: 9.906 on 3 degrees of freedom
# Multiple R-squared:  0.7501,	Adjusted R-squared:  0.6668 (약67%) 
##모형이 75%로 잘 설명되고 있다는 뜻 
#통계설명가능- 예측값을 믿을 수 있는 정도 
# F-statistic: 9.004 on 1 and 3 DF,  p-value: 0.05764

coef(pc_iq)
predict(pc_iq,data.frame(c(117,117,117,117,117))) 
#예측값 계산 


#자동차 주행속도speed와 제동거리dist간의 관계 파악
cars #str(cars)

attach(cars)
plot(speed,dist,pch=20,col='blue')

#주행속도와 제동거리간 회귀식은?
lm(dist~speed)      # y = -17.579+3.932x

distsp<-lm(dist~speed)
abline(distsp,pch=20,col='blue')

#속도가 100km일때 제동거리 예측
-17.579+3.932 * 100

cars
cars$dist

#7   10   18
#8   10   26
#9   10   34

summary(distsp)
# p-value: 1.49e-12 (0.05) 유의범위 5% 내 -통계 유의미
# Adjusted R-squared:  0.6438 64%정도 신뢰 가능성 존재
# speed         3.9324     0.4155   9.464 1.49e-12 ***



#놀이동산 만족도 여부 회귀분석 
parks<-read.csv('c:/JAVA/park.csv')
attach(parks)
#놀이기구ride와 전체만족도overall 사이 회귀분석 
ovri<-lm(overall~rides)

plot(overall~rides,pch=20)
abline(ovri,pch=20,col='blue')
ovri            #y=-94.962+1.703x

#회귀모형 검증 및 적합도 확인 
#F검증
#rides         1.7033     0.1055   16.14   <2e-16 ***
#rides 값은 유의수준  5%보다 작음 : 회귀식이 유의미
#즉, rides값이 증가하면 overall도 증가함
# p값
    # p-value: < 2.2e-16 (통계가 유의미)
#R제곱
  	# Adjusted R-squared:  0.3421 (설명력 34%)
summary(ovri)

#다항선형 회귀분석 
#단순선형회귀분석에 비해 변수가 2개 이상 증가
#놀이기구에 대한 전체만족도를 분석에서 
#놀이기구+게임+청결도와 전체만족도 관계 분석 

lm_park<-lm(overall~rides+games+clean)
#회귀식:-131.67877 + 0.57798a +0.26028b+1.28381c

summary(lm_park)
#p값: p-value: < 2.2e-16
#r제곱: Adjusted R-squared:  0.4358 

library(MASS)
head(Cars93)
attach(Cars93)
lm(Price~EngineSize+RPM+Weight, data=Cars93)
summary(lm(Price~EngineSize+RPM+Weight,data=Cars93))


#로지스틱 회귀분석
#선형 회귀분석에서는 설명변수를 입력하면
#수치형으로 결과를 얻게 됨
#따라서, 소득, 시험성적, 연간소득을 알려면
#선형회귀분석 사용 

#하지만, 내가 예측하고자 하는 것이 수치적으로 나타내기 어려운 경우
#로지스틱 회귀분석 이용
#예를 들어 고객의 부도발생 여부, 조난된 배에서 살아남을지 여부, 
#어떤 학생의 최종학력 등

#회귀분석이므로 기본적으로 지도 학습에 속하고 (기계학습 가능)
#다양한 분야에서 분류 및 예측을 위한 기법으로 사용

#단, 선형회귀 분석과 달리 결과변수가 범주형 데이터인 경우
#사용되는 기법임을 명심하자 

glm()

#다음 시험점수와 순위로 해당 학교에 입학 가능여부 확인
#입학여부admit, gre(대학졸업성적), gpa(내신성적), 학교등급rank
#admit : 1 입학성공 0 입학실패
collage<-read.csv('c:/JAVA/collage.csv')

#rank는 이산형 데이터이므로 범주형 변수로 변환 
range(collage$rank)    #1~4
collage$rank<-as.factor(collage$rank)


#회귀식 분석
attach(collage)
glm_collage<-glm(admit~gre+gpa+rank, 
                 family ='binomial' ) 
                  #값이 0 또는 1 이므로이 조건이 들어가야함

summary(glm_collage)














