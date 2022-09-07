from itertools import *


def painter_name():
    for name in [
        'Salvador Dali',
        'Hieronymus Bosch',
        'Russeau',
        'Van Gogh'
    ]:
        yield name


def style():
    for name in [
        'surrealist',
        'impressionist',
    ]:
        yield name


def what():
    for name in [
        'cat',
        'camel',
        'elephant'
    ]:
        yield name


def merger(*gens):
    yield from product(*gens)


def prompter(*gens):
   for words in merger(*gens):
      yield " ".join(words)


def test1():
    for n in painter_name():
        print(n)


def test2():
    for n in prompter(
        ['paint'], ['in'],
        style(), ['style'], ['a'],
        painter_name(),
        ['painting'], ['about'], what()):
        print(n)


if __name__ == "__main__":
    test2()
