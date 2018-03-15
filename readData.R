#readData.R

#데이터를 외부로부터 가져오는 방법
#1. 키보드로 입력 -edit(), fix()
#작은 데이터 집합을 사용해야 하는 경우 유용

smalldata<-data.frame(age=numeric(0),weight=numeric(0.0))
smalldata<-edit(smalldata)
smalldata

#R의 데이터 타입: numeric, character, logical

managerdata<-data.frame(manager=numeric(0), date=character(0),country=character(0),gender=character(0),age=numeric(0),q1=numeric(0),q2=numeric(0),q3=numeric(0),q4=numeric(0),q5=numeric(0))

managerdata<-edit(managerdata)
managerdata

#텍스트형태로 입력 - read.table() 함수를 사용
txtdata<-'
age weight
1 0.7
2 1.3
3 2.1
'
txtdata

smalldata<-read.table(header=T,text=txtdata)
smalldata

txtdata<-'
manager date country gender age q1 q2 q3 q4 q5
1 10/24/14 US M 32 5 4 5 5 5
2 10/28/14 US F 45 3 5 2 5 5 
3 10/01/14 UK F 25 3 5 5 5 2
4 10/12/14 UK M 39 3 3 4 
5 05/01/14 UK F 99 2 2 1 2 1'
txtdata

managerdata<read.table(header=T, text=txtdata)
managerdata

#구분된 텍스트 파일에서 데이터 읽어오기 
#read.table(파일명, 옵션)

sales<-read.table('c:/JAVA/sales.txt',sep=',',header=F)
#컬럼이름을 의미하는 헤더가 없어서 임의의 컬럼명이 자동부여
sales<-read.table('c:/JAVA/sales.txt',sep=',',header=F,
                  colClasses=c('character','numeric','numeric')) 
#logical 이라고 하면 오류가 뜬다 세번째 속성은 논리형이 아니라 수치형이기 때문!
#파일로 읽어들이는 데이터의 자료유형 설정 - colClasses
#sep=, ,를 구분자로 해준다는 뜻임
#header는 속성의 이름을 나타내줄것인가 말것인가를 나타낸다 
str(sales)
sales

?read.table


#Students
students<-read.table('c:/JAVA/students.txt',sep='\t',header=T)
str(students)
students

#Stations
stations<-read.table('c:/JAVA/stations.csv',sep=',',header=F)
str(stations)
stations

#SummerMedalists
SummerMedallists<-read.table('c:/JAVA/SummerMedallists.txt',sep='\t',header=T)
str(SummerMedallists)
SummerMedallists


#csv 파일 읽기
#read.csv(파일명, 옵션들...)
#
?read.csv
?read.csv2

stations = read.csv('c:/JAVA/stations.csv',header=F)
stations = read.csv('c:/JAVA/stations.csv',header=F, na.strings='')
stations

#엑셀로 데이터 읽어오기 
install.packages('readxl')
library('readxl')
medal<-read_excel('c:/JAVA/SummerMedallists.xlsx',sheet=1)
str(medal)

#또 다른 패키지(xlsx)
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')
install.packages('rJava')
install.packages('xlsx')
library('xlsx')
medal_java <-read.xlsx("c:/Java/SummerMedallists.xlsx", sheetIndex = 1)
str(medal_java)
medal_java

#html,xml파일 읽어오기
install.packages('XML')
library('XML')
library('methods')
xmldata<-xmlParse('c:/JAVA/emp.xml')
empdata<-xmlToDataFrame('c:/JAVA/emp.xml')
xmldata
empdata

#JSON형식으로 데이터 읽기
install.packages('jsonlite')
library('jsonlite')
install.packages('httr')
library('httr')

#jsondata<-fromJSON('c:/JAVA/primer-dataset.json')
jsondata<-fromJSON('https://api.github.com/users/hadley/repos')
str(jsondata)
names(jsondata)  #JSON 데이터의 키를 출력 

#대용량 파일 읽어오기 
zip1<-read.table('c:/JAVA/서울특별시-2017.10.csv',sep=',', stringsAsFactors = F, header=T, fill=T)
#stringsAsFactors = F 이것은 false로 주면 팩터로 바뀌지 않고 계속 문자로 유지된다는 뜻임 
str(zip1)
head(zip1)

zip2<-read.csv('c:/JAVA/서울특별시-2017.10.csv',sep=',', stringsAsFactors = F, header=T)
str(zip2)
head(zip2)

install.packages('data.table')
library('data.table')

?fread

zip3<-fread('c:/JAVA/서울특별시-2017.10.csv', sep=',', header=T, stringsAsFactors = F)
str(zip3) 
head(zip3)

#관계형 데이터베이스 
#R에서는 RDMBS에서 데이터를 읽어올 수 잇는 다양한 환경 지원
#R<-MySQL
install.packages('RMySQL')
library('RMySQL')

mysqlconn <- dbConnect(MySQL(),user='zzyzzy',password='Abcdef_12', dbname='zzyzzy', host='192.168.248.130')

dbListTables(mysqlconn) #테이블목록 출력

empdata<-dbSendQuery(mysqlconn, 'select * from employees')
emp <-fetch(empdata)
#emp <-dbGet(mysqlconn, 'select * from employees')
str(emp)

dbWriteTable(mysqlconn, '테이블명', 객체명, overwrite=T)

dbDisconnect(mysqlconn)

#R<-Oracle
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_152')
install.packages('DBI',dep=T)
install.packages('RJDBC',dep=T)
install.packages('rJava')
library('DBI')
library('RJDBC')
library('rJava')

drv <-JDBC('oracle.jdbc.OracleDriver',classPath = 'D:/빅데이터/JAVA/jdbc/ojdbc7.jar')
oraconn<-dbConnect(drv,'jdbc:oracle:thin:@192.168.248.130:1521:xe','hr','hr')
emp <- dbGetQuery(oraconn,'select * from EMPLOYEES')
dbDisconnect(oraconn)
emp



