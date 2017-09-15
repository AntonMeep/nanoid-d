nanoid.d [![Page on DUB](https://img.shields.io/dub/v/nanoid-d.svg?style=flat-square)](http://code.dlang.org/packages/nanoid-d)[![License](https://img.shields.io/dub/l/nanoid-d.svg?style=flat-square)](https://github.com/ohdatboi/nanoid-d/blob/master/LICENSE)[![Build Status TravisCI](https://img.shields.io/travis/ohdatboi/nanoid-d/master.svg?style=flat-square)](https://travis-ci.org/ohdatboi/nanoid-d)
=============

**nanoid.d** is a tiny, URL-friendly unique string ID generator for D, developed as a D rewrite of [nanoid](https://github.com/ai/nanoid) for JavaScript.

**Safe:** *(nope)* nanoid.d is safe if you use a cryptographically strong random API, but `Random` from `std.random` is used by default.

**Small:** *2* lines of code. Yep, only 2 of them. `std.random` provides a function to choose random elements from an array, which has a proper distribution of symbols.
It can be done in 1 line, but, you know, *optimizations* are very important.

**Fast:** `nanoid()` returns a lazy range, which means that everything is computed only when needed.

