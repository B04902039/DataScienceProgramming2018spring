library(httr)
library(NLP)
library(RColorBrewer)
library(wordcloud)
library(tm)
library(jsonlite)
token  = "EAACEdEose0cBAP6pGuTaZC024DRTmHAVWXUappjZACKiE5ZBKMPZAG2qmZBGkks4oDZAhUdojLr73FBtkUY8Hw3ym1PExcZCUtZBUZAw8P9sSR0JCWq9CKoU1qwNscShxTMYljyEtyudO0gQQ4ICFPgMZAxkGu6eqI5ipfwtVJNZAhXqhgSpP2mxHI7SOYro1XjzZCwPnsl2YiTGMAfk0cjlwEpsJGhO8q6yOBUZD"
B_Obama = "https://graph.facebook.com/v2.12/barackobama?fields=posts%7Bmessage%7D&access_token="
D_Trump = "https://graph.facebook.com/v2.12/DonaldTrump?fields=posts%7Bmessage%7D&access_token="
url_Obama = paste0(B_Obama, token)
url_Trump = paste0(D_Trump, token)
res_O = httr::GET(url_Obama)
res_T = httr::GET(url_Trump)
posts_O  = httr::content(res_O)
posts_T  = httr::content(res_T)

texts_O = ""
texts_T = ""
for (i in c(1:25)) {
  texts_O = paste(texts_O, posts_O$posts$data[[i]]$message)
  texts_T = paste(texts_T, posts_T$posts$data[[i]]$message)
}

doc_O = Corpus(VectorSource(texts_O))
doc_T = Corpus(VectorSource(texts_T))

doc_O = tm_map(doc_O, content_transformer(tolower))
doc_T = tm_map(doc_T, content_transformer(tolower))

doc_O = tm_map(doc_O, removeNumbers)
doc_T = tm_map(doc_T, removeNumbers)

doc_O = tm_map(doc_O, removeWords, stopwords("english"))
doc_T = tm_map(doc_T, removeWords, stopwords("english"))

doc_O = tm_map(doc_O, removePunctuation)
doc_T = tm_map(doc_T, removePunctuation)

m_O = as.matrix(TermDocumentMatrix(doc_O))
m_T = as.matrix(TermDocumentMatrix(doc_T))

v_O = sort(rowSums(m_O),decreasing = TRUE)
d_O = data.frame(word = names(v_O), freq = v_O)
head(d_O, 10)
v_T = sort(rowSums(m_T),decreasing = TRUE)
d_T = data.frame(word = names(v_T), freq = v_T)
head(d_T, 10)

wordcloud(words = d_O$word, freq = d_O$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
wordcloud(words = d_T$word, freq = d_T$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))