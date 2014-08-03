
import nltk
from os importp path
from nltk.tokenize import word_tokenize

nltk.data.path.append(path.join(path.dirname(__file__), 'nltk_data/')

# food ride map stay

stemmer = nltk.PorterStemmer()
lemmatizer = nltk.stem.WordNetLemmatizer()

contexts = [
    'food', 'ride', 'map', 'stay'
]

word_2_context = {}

def get_words(query):
    return set([stemmer.stem(lemmatizer.lemmatize(word))
                for word in word_tokenize(query.lower())])

def get_contexts(query):
    words = get_words(query)
    contexts = set()
    for word in words:
        contexts |= word_2_context.get(word, set())
    return list(contexts)

def setup():
    for name in contexts:
        words = set()
        with open(path.join(path.dirname(__file__), 'data/' + name + '.txt')) as f:
            w = get_words(f.read())
            words |= w

        for word in words:
            l = word_2_context.setdefault(word, set())
            l.add(name)

setup()

if __name__ == "__main__":
    while True:
        print get_contexts(raw_input(">"))
