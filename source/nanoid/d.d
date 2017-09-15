module nanoid.d;

version(unittest) import fluent.asserts;
import std.random : rndGen, isUniformRNG, choice, Random;
import std.range : generate;

/**
 * Unique string ID generator
 * Params:
 *   alphabet = alphabet to use. Maximum length is 256 characters
 *
 *   rand = Random generator to use. Uses rndGen by default, which isn't a cryptographically strong algorithm!
 * Returns: An InfiniteRange of random characters from alphabet
 */
@safe auto nanoid(RandomGen = Random)(
	in char[] alphabet = "_~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".dup,
	RandomGen rand = rndGen()
)
if(isUniformRNG!RandomGen)
in {
	assert(alphabet.length <= 256, "Maximum length of alphabet is 256");
} body {
	import std.string : representation;
	import std.conv : to;

	auto alph = alphabet.representation;
	return generate!(() => alph.choice(rand).to!char);
}

unittest {
	import std.range : take;
	import std.array : array;
	nanoid(['a']).take(5).array.idup
		.should.be.equal("aaaaa").because("has options");
}

unittest {
	import std.algorithm : map, each;
	import std.range : iota, take;
	import std.conv : to;
	import std.random;

	char[] ALPHABET = "abcdefghijklmnopqrstuvwxyz".dup;
	auto LENGTH = 5;
	auto COUNT = 100 * 1000;

	size_t[char] chars;
	foreach(c; ALPHABET)
		chars[c] = 0;

	iota(COUNT)
		.each!(a => nanoid(ALPHABET, Random(unpredictableSeed)) // So each nanoid() gets new random generator
			.take(LENGTH)
			.each!(x => ++chars[x]));

	chars.byValue
		.map!(a =>
		      (a * ALPHABET.length).to!float / (COUNT * LENGTH).to!float)
		.each!(a => a.should.be.approximately(1.0, 0.1).because("has flat distribution"));
}
