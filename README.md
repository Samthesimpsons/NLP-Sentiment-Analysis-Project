# Sentiment-Analysis-Project
40.220 The Analytics Edge Twitter Sentiment Analysis Kaggle Competition 

## Details
**Project Title:** Twitter Sentiment Analysis Kaggle Competition

**Description:** The task is to develop an algorithm that determines what sort of weather the tweets reference. Specifically, the challenge is to determine whether a tweet has a negative, neutral, or positive sentiment. The following datasets are provided:

• train.csv: 22,500 tweets with the corresponding classification / sentiment. The integers 1, 2, and 3 indicate negative, neutral, and positive sentiment, respectively.

• test.csv: 7,500 tweets. Naturally, this dataset has no labels. It will be used to quantify the performance of the algorithms.

The performance of the algorithms will be then evaluated based on their capability of classifying correctly the sentiment of each tweet in the test dataset. In particular, the evaluation will be based on the accuracy metric, defined as the ratio between the number of correctly-classified samples and the total number of samples. Kaggle will calculate the value of the accuracy on two subsets of the test dataset, named public and private. The results on the public dataset will be available during the competition (public leaderboard), while the results on the private one will be available at the end of the competition (private leaderboard).

## Team 7 Members
1. Lee Min Shuen (1004244)
2. Sim Wei Xuan, Samuel (1004657)
3. Muhammad Hazwan Bin Mohamed Hafiz (1004122)

## Dependencies
- R version 4.0.4
- Python 3.8 (Using reticulate for R-Python interoperability for the Keras library)
- Keras 2.7.0
- Tensorflow 2.4.0

Note when loading reticulate in R, rminiconda will be installed by default to load a python environment. Of which follow the instructions to install keras and tensorflow in the r-reticulate conda environment. 

In conda prompt, type:
```bash
$ conda activate r-reticulate
$ pip install tensorflow==2.4.0
$ pip install keras
```

If python is already installed in the system, you can force reticulate to use python by setting the path.

In R console, type:
```bash
reticulate::use_python("path to python.exe",required=T)
```

Then to install tensorflow and keras, in command prompt type:
```bash
$ pip install tensorflow==2.4.0
$ pip install keras
```
## How to Run
1. We have already created our own word embeddings specific to our dataset from pre-trained word embeddings using ```Word Embedding Weights/create_word_embeddings.R```.
2. For model training, open ```Final_Submission.Rmd```, which has all our steps inside.
3. For viewing, open ```Final_Submission.html``` for a readable html webpage.

## Directories
```bash
├───Data
└───Word Embedding Weights
    └───Pre-Trained Weights
```
