library(httr)
library(NLP)
library(RColorBrewer)
library(wordcloud)
library(tm)
token  = ""
B_Obama = "https://graph.facebook.com/v2.12/barackobama?fields=posts%7Bmessage%7D&access_token="
D_Trump = "https://graph.facebook.com/v2.12/DonaldTrump?fields=posts%7Bmessage%7D&access_token="
url_Obama = paste0(B_Obama, token)
url_Trump = paste0(D_Trump, token)
res_O = httr::GET(url_Obama)
res_T = httr::GET(url_Trump)
posts_O  = content(res_O)
posts_T  = content(res_T)

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

#doc_O = tm_map(doc_O, removeNumbers())
#doc_T = tm_map(doc_T, removeNumbers())

doc_O = tm_map(doc_O, removeWords("english"))
doc_T = tm_map(doc_T, removeWords("english"))

doc_O = tm_map(doc_O, removePunctuation)
doc_T = tm_map(doc_T, removePunctuation)

