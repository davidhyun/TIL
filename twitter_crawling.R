getwd()
setwd("C:/Rexam/nomasknopass/twitter_crawling"); getwd()
# rm(list=ls())

# install.packages("rtweet")
# install.packages("readr")
# install.packages('openssl')
library(rtweet)
library(dplyr)
library(readr)

# API token 정보
appname <- "R mini project"
api_key <- "hYivzEGfVHiJplk0zQ9WXSlfi"
api_secret <- "jwwIR5VlCYsnruC53W2yZknoGG64QaKymV2SbN3xziwoClYrqu"
access_token <- "1310822973826166795-kDGQencMDl1wiKKgNuohEmluPvGpbF"
access_token_secret <- "rEsDqcpphuJLd5iJeE0zyae97gVwwSbPHeTjBu2L0VNpI"
twitter_token <- create_token(
  app = appname,
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)


# 검색 keyword
query <- "코스크 OR 턱스크"
query <- "마스크"
query <- enc2utf8(query) # CP949 -> UTF-8

# search_tweets API
??search_tweets
result <- search_tweets(query,
                        n=18000,
                        include_rts=FALSE,
                        type="recent",
                        token=twitter_token,
                        retryonratelimit=TRUE)

View(result)
tweet <- result %>% select(user_id, created_at, screen_name, text)
head(tweet)


#getwd()
#write.table(tweet, file="query(코스크 OR 턱스크).csv", sep=',', row.names=FALSE, col.names=TRUE)

#keyword_df <- read.table(file="./query(코스크 OR 턱스크).csv", sep=',', header=TRUE, fill=TRUE) # 결측위치에 NA 입력
#View(keyword_df)


tweet_rawdf <- as.data.frame(tweet)
View(tweet_rawdf)

# 중복행 제거
nrow(tweet_rawdf)
#nrow(unique(tweet_rawdf))
#tweet_df <- unique(tweet_rawdf) # 제대로 제거가 안됨
tweet_df <- tweet_rawdf[-which(duplicated(tweet_rawdf$user_id)), ] # 한 명당 하나의 트윗만 남김, 광고성 트윗 제한
View(tweet_df)


##### 문자열 처리 #####
text <- tweet_df$text

# 자동 띄어쓰기 KoSpacing
# java.lang.ArrayIndexOutOfBoundsException 오류는 띄어쓰기가 안된채로 문장이 너무 길때 발생
install.packages('vctrs')
install.packages('reticulate')
install.packages('rlang')
install.packages('jsonlite')
remotes::install_github("mrchypark/KoSpacing") # ver 0.1.2
library(KoSpacing) # 198자 제한이 있다
packageVersion('KoSpacing') # ver 0.1.2 (ver 0.1.1 이상인지 체크)
set_env()

spacing('아버지가방에들어가신다') # AttributeError: 'str' object has no attribute 'decode' 오류시 해당파일에서.decode('utf-8') 여러군데 제거
spacing('기침이나고열이나기전에마스크잘쓰고다닙시다') # 띄어쓰기 잘해줌
spacing('기침이 나고 열이 나기 전 마스크 잘 쓰고 다닙시다') # 이미 띄어써져있으면 제대로 띄어쓰기 못함


text <- gsub(" ", "", text) # 공백 제거
text_df <- as.data.frame(text)
text_df$over200 <- ifelse(nchar(text_df$text) >= 198, TRUE, FALSE) # 198자가 넘는 행을 체크
text_df <- text_df[text_df$over200==FALSE, ] # 198자가 미만 행만 추출
text_vector <- text_df$text # text열만 벡터로 추출 (13711행)


spacing_text_df <- as.data.frame(unlist(spacing(text_vector)))
names(spacing_text_df)[names(spacing_text_df)=='unlist(spacing(text_vector))'] = 'text' # 열 이름 변경
View(spacing_text_df)



# 특수문자, 영소문자, 영대문자, 숫자, 개행문자 제거
text <- spacing_text_df$text
text <- gsub("[[:punct:][:lower:][:upper:][:digit:][:cntrl:]]", "", text) # \u로 시작하는 단어제거는 어렵다(pass)
text <- gsub("마스크", "", text)
text <- gsub("ㅋ+|ㅎ+|ㅠ+|ㅜ+", "", text)
#text <- gsub("새끼|존나|시발", "", text)
text


##### 자연어 처리 #####
install.packages('digest')
library(KoNLP)
library(stringr)
useSejongDic() # 세종사전 객체를 생성


# 명사추출
words <- extractNoun(text)
words_unlist <- unlist(words)
words_unlist <- Filter(function(x) {nchar(x) >= 2}, words_unlist) # 2자 이상만 필터링

wordcount <- table(words_unlist) # table() 함수로 개수 세기
wordcount <- head(sort(wordcount, decreasing=T), 50) # 빈도수별로 50개까지
wordcount

# 보통명사만 추출하기
doc1 <- SimplePos22(text)
doc2 <- paste(SimplePos22(text))
doc3 <- str_match_all(doc2, "[가-힣]+/NC") # str_match_all(개체, 찾을 문자열)
doc3 <- unlist(doc3)
doc4 <- gsub("/NC", "", doc3)
doc4 <- Filter(function(x) {nchar(x) >= 2}, doc4)

wordcount_NC <- table(doc4)
wordcount_NC <- head(sort(wordcount_NC, decreasing=T), 50)
wordcount_NC

##### 워드클라우드 시각화 #####
library(wordcloud2)
# 5개의 패키지가 설치되어있어야 figPath를 사용할 수 있음... 
# https://m.blog.naver.com/CommentList.nhn?blogId=hwan0447&logNo=221241027145
#install.packages('htmlwidgets')
#install.packages('htmltools')
#install.packages('jsonlite')
#install.packages('yaml')
#install.packages('base64enc')
library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)

par(mar=c(1,1,1,1))
wordcloud_mask <- wordcloud2(wordcount_NC, size=0.5, color='random-light', backgroundColor='white')
wordcloud_mask
