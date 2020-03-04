
// EMR configurations and data preprocessing
wget http://files.grouplens.org/datasets/movielens/ml-1m.zip
unzip ml-1m.zip


cat ml-1m/ratings.dat | sed 's/::/,/g' | cut -f1-3 -d, > ratings.csv

hadoop fs -put ratings.csv /ratings.csv


mahout recommenditembased --input /ratings.csv --output recommendations --numRecommendations 10 --outputPathForSimilarityMatrix similarity-matrix --similarityClassname SIMILARITY_COSINE



hadoop fs -ls recommendations
hadoop fs -cat recommendations/part-r-00000 | head



// building python service
sudo easy_install twisted
sudo easy_install klein
sudo easy_install redis


wget http://download.redis.io/releases/redis-2.8.7.tar.gz
tar xzf redis-2.8.7.tar.gz
cd redis-2.8.7
make
./src/redis-server &


// Need to create hello.py with the code given
nano hello.py

// start the service
twistd -noy hello.py &


// get recomendations
curl localhost:8080/37
