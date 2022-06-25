# Clear Environment -------------------------------------------------------
rm(list=ls()) 

# Libraries ---------------------------------------------------------------
library(tidyverse) 
library(keras) 
library(caTools)
library(tensorflow)
library(reticulate) 
reticulate::use_python("path_to_python",required=T)

# Text Pre-processing
library(tidytext) 
library(dplyr)
library(textshape)
library(lexicon)
library(textclean)

# Import ------------------------------------------------------------------
train <- read.csv("Data/train.csv", stringsAsFactors=FALSE)
test <- read.csv("Data/test.csv", stringsAsFactors=FALSE)

# Prepare ------------------------------------------------------------------
train <- train %>% mutate(Split = "train")
test <- test %>% mutate(Split = "test")

# Combine data for tokenization
full <- data.frame(rbind(train %>% select(-sentiment), test%>% select(-id)))

# Process Text --------------------------------------------------------------
raw_text <- full$tweet

processed_text <- raw_text %>% 
  tolower() %>%
  replace_word_elongation() %>% 
  replace_internet_slang() %>%
  replace_emoticon() %>%
  replace_url() %>%
  replace_email() %>%
  replace_html()

full_processed <- full
full_processed$tweet <- processed_text

# Tokenizer  ---------------------------------------------------------------
max_words <- 15000 # Maximum number of words to consider as features
maxlen <- 64 # Text cutoff after n words

# Prepare to tokenize the text
texts <- full_processed$tweet

tokenizer <- text_tokenizer(num_words = max_words) %>% 
  fit_text_tokenizer(texts)

# Tokenize - i.e. convert text into a sequence of integers
# sequences <- texts_to_sequences(tokenizer, texts)
word_index <- tokenizer$word_index

# Create Embedding matrix from pre-trained embedding

# Glove Twitter -------------------------------------------------------------------
dir <- "Pre-Trained Weights/"
lines <- readLines(file.path(dir, "glove.twitter.27B.200d.txt"))

twitter_embeddings_index <- new.env(hash = TRUE, parent = emptyenv())

pb <- txtProgressBar(min = 0, max = length(lines), style = 3)
for (i in 1:length(lines)){
  line <- lines[[i]]
  values <- strsplit(line, " ")[[1]]
  word <- values[[1]]
  twitter_embeddings_index[[word]] <- as.double(values[-1])
  setTxtProgressBar(pb, i)
}

twitter_embedding_dim = 200
twitter_embedding_matrix = array(0, c(max_words, twitter_embedding_dim))

for (word in names(word_index)){
  index <- word_index[[word]]
  if (index < max_words){
    twitter_embedding_vector <- twitter_embeddings_index[[word]]
    if (!is.null(twitter_embedding_vector))
      twitter_embedding_matrix[index+1,] <- twitter_embedding_vector # Words without an embedding are all zeros
  }
}

gc()
saveRDS(twitter_embedding_matrix, "glove_twitter_27B_200d.rds")

# FastText Twitter -----------------------------------------------------------
dir <- "Pre-Trained Weights/"
lines <- readLines(file.path(dir, "fasttext_english_twitter_100d.vec"))

fasttext_twitter_embeddings_index <- new.env(hash = TRUE, parent = emptyenv())

lines <- lines[2:length(lines)]

pb <- txtProgressBar(min = 0, max = length(lines), style = 3)
for (i in 1:length(lines)){
  line <- lines[[i]]
  values <- strsplit(line, " ")[[1]]
  word <- values[[1]]
  fasttext_twitter_embeddings_index[[word]] <- as.double(values[-1])
  setTxtProgressBar(pb, i)
}

fasttext_twitter_embedding_dim <- 100
fasttext_twitter_embedding_matrix <- array(0, c(max_words, fasttext_twitter_embedding_dim))

for (word in names(word_index)){
  index <- word_index[[word]]
  if (index < max_words){
    fasttext_twitter_embedding_vector <- fasttext_twitter_embeddings_index[[word]]
    if (!is.null(fasttext_twitter_embedding_vector))
      fasttext_twitter_embedding_matrix[index+1,] <- fasttext_twitter_embedding_vector # Words without an embedding are all zeros
  }
}

gc()
saveRDS(fasttext_twitter_embedding_matrix, "fasttext_english_twitter_100d.rds")




