
import nltk
from os import path
from nltk.tokenize import word_tokenize

nltk.data.path.append(path.join(path.dirname(__file__), 'nltk_data/'))

stemmer = nltk.PorterStemmer()
lemmatizer = nltk.stem.WordNetLemmatizer()

def extract_words(text):
    return set([stemmer.stem(lemmatizer.lemmatize(word))
                for word in word_tokenize(text.lower())])

class Query(object):
    def __init__(self, text):
        self.text = text.strip().lower()
        self.words = extract_words(text)

class Matcher(object):
    contexts = None

    def add_context(self, context):
        if self.contexts is None:
            self.contexts = set()
        self.contexts.add(context)
    
    def load_data_file(self, fn):
        fn = path.join(path.dirname(__file__), 'data/' + fn)
        with open(fn, 'r') as f:
            return f.read()

    def does_match(self, query):
        """ implement this in subclasses """
        return False

class KeywordMatcher(Matcher):
    def __init__(self, fn):
        self.words = extract_words(self.load_data_file(fn))

    def does_match(self, query):
        for word in query.words:
            if word in self.words:
                return True

class ExactMatcher(Matcher):
    def __init__(self, fn):
        lines = self.load_data_file(fn).split('\n')
        self.strings = set([line.strip().lower() for line in lines])

    def does_match(self, query):
        return query.text in self.strings

class ContextEngine(object):
    def __init__(self, config):
        self.matchers = set()
        for name, matchers in config.items():
            for matcher in matchers:
                matcher.add_context(name)
                self.matchers.add(matcher)

    def get_contexts(self, input_text):
        query = Query(input_text)
        contexts = set()
        for matcher in self.matchers:
            if matcher.does_match(query):
                contexts |= matcher.contexts
        return contexts

def make_cache(cls):
    cache = {}
    def wrapper(filename):
        if filename in cache:
            return cache[filename]
        obj = cls(filename)
        obj.name = filename
        cache[filename] = obj
        return obj
    return wrapper

KeywordMatcher = make_cache(KeywordMatcher)
ExactMatcher = make_cache(ExactMatcher)

engine = ContextEngine({
    'food': [KeywordMatcher('food.kw.txt'), ExactMatcher('restaurants.txt')],
    'ride': [KeywordMatcher('ride.kw.txt')],
    'map': [KeywordMatcher('map.kw.txt'), ExactMatcher('restaurants.txt')],
    'stay': [KeywordMatcher('stay.kw.txt')],
    'artist': [ExactMatcher('artists.txt')]
})

if __name__ == "__main__":
    while True:
        print engine.get_contexts(raw_input(">"))
