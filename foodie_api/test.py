from nltk.corpus import wordnet as wn
import nltk

apple = wn.synset('apple.n.01')
food = wn.synset('ingredient.n.01')
print(food.wup_similarity(apple))
