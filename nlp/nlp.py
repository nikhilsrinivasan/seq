
import re
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

    def load_fragments(self, fn):
        return self.load_data_file(fn).lower().strip().split()

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
        self.strings.remove("")

    def does_match(self, query):
        return query.text in self.strings

class AddressMatcher(Matcher):

    re_place = "\d+\s+\w+(\s+\w+)?(\s\w+)?\s+(%s)"
    re_citystate = "\w+(\s+\w+)?(\s+\w+)?\s*,\s*(%s)"

    def __init__(self):
        self.places = set(self.load_fragments('places.txt'))
        suffixes = self.load_fragments('street_suffixes.txt')
        self.re_place = re.compile(self.re_place % '|'.join(suffixes))
        states = self.load_fragments('states.txt')
        self.re_citystate = re.compile(self.re_citystate % '|'.join(states))

    def does_match(self, query):
        if self.re_place.match(query.text):
            return True
        if self.re_citystate.match(query.text):
            return True
        if query.text in self.places:
            return True

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
        return list(contexts)

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

def make_singleton(cls):
    inst = cls()
    def wrapper():
        return inst
    return wrapper

KeywordMatcher = make_cache(KeywordMatcher)
ExactMatcher = make_cache(ExactMatcher)
AddressMatcher = make_singleton(AddressMatcher)

engine = ContextEngine({
    'food': [KeywordMatcher('food.kw.txt'), ExactMatcher('restaurants.txt')],
    'ride': [KeywordMatcher('ride.kw.txt'), AddressMatcher()],
    'map': [KeywordMatcher('map.kw.txt'), ExactMatcher('restaurants.txt'), AddressMatcher()],
    'stay': [KeywordMatcher('stay.kw.txt'), AddressMatcher()],
    'flight': [KeywordMatcher('flight.kw.txt'), AddressMatcher()],
    'artist': [ExactMatcher('artists.txt')],
})

if __name__ == "__main__":
    while True:
        print engine.get_contexts(raw_input(">"))
