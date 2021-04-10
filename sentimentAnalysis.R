library(SocialMediaLab)

apikey <- "AIzaSyBp_N9NkfBegyMVyiBAlMNawXic9kbiEb8"
key <- AuthenticateWithYoutubeAPI(apikey)

video <- c('TfWMTxsOZdI&t=67s','zp0rHdXHKSI')

myYoutubeData <- CollectDataYoutube(video, apikey, writeToFile=TRUE, verbose=TRUE, maxComments=100)

str(myYoutubeData)

data <- read.csv("youtube.csv")
str(data)

data <- data[data$ReplyToAnotherUser != FALSE,]

y <- data.frame(data$User, data$ReplyToAnotherUser)

library(igraph)
net <- graph.data.frame(y,directed=T)
net <- simplify(net)
V(net)
E(net)
V(net)$label <- V(net)$name
V(net)$degree <- degree(net)
hist(V(net)$degree,
     col='green',
     main='Histogram of the Node Degree',
     ylab='Frequency',
     xlab='Degree of Verticles')
plot(net,
     vertex.size= 0.2*V(net)$degree, 
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.01*V(net)$degree)
library(syuzhet)

data1 <- read.csv("youtube.csv")
str(data1)
comments <- iconv(data$Comment, to='utf-8')
s <- get_nrc_sentiment(comments)
head(s)

s$neutral <- ifelse(s$negative + s$positive==0, 1, 0)
head(s)
comments[3]

barplot(100*colSums(s)/ sum(s),
        las = 2,
        col= rainbow(10),
        ylab = 'Percentage',
        main = 'Sentiment Scores for Youtube Comments')
