# NAME

Test::QuickGen - Utilities for generating random test data

# SYNOPSIS

    use Test::QuickGen qw(:all);

    my $id = id();
    my $str = ascii_string(10);
    my $utf8 = utf8_string(20);
    my $clean = utf8_sanitized(15);

    my $rand = between(1, 100);
    my $opt = nullable("value");
    my $item = pick(qw(a b c));

    my $words = words(\&ascii_string, 5);

# DESCRIPTION

`Test::QuickGen` provides a set of utility functions for generating random
data, primarily intended for testing purposes. These generators are simple,
fast, and have minimal dependencies.

All functions are exported by default.

# IMPORTING

Nothing is exported by default.

Import functions explicitly:

    use Test::QuickGen qw(id ascii_string);

Import groups of functions using tags:

    use Test::QuickGen qw(:all);
    use Test::QuickGen qw(:utf8);
    use Test::QuickGen qw(:basic);

See source for the exact composition.

- `:all`

    All available functions.

- `:utf8`

    `utf8_string`, `utf8_sanitized`.

- `:basic`

    `id`, `between`, `pick`, `nullable`.

# FUNCTIONS

## id

    my $id1 = id();
    my $id2 = id();

    # $id1 != $id2

Returns a monotonically increasing integer starting from 0.

The counter is process-local and resets each time the program runs.

## string\_of

    my $str = string_of(10, qw(a b c));

Generates a random string of length `$n` using the provided list of characters.

- `$n` must be a non-negative integer.
- At least one character must be provided.
- Characters are selected uniformly at random.

## ascii\_string

    my $str = ascii_string(10);

Generates a random ASCII string length `$n`.

The character set includes all lowercase letters (a-z), uppercase letters (A-Z),
digits (0-9) and underscore (\_).

## utf8\_string

    my $str = utf8_string(10);

Generates a random UTF-8 string of `$n` characters.

The generator:

- Includes visible Unicode characters up to code point `0x2FFF`.
- Excludes control characters and invalid Unicode ranges.
- Skips surrogate pairs and non-characters.

Note: Because characters may vary in byte length, this function targets
character count (not byte length).

## utf8\_sanitized

    my $clean = utf8_sanitized(10);

Generates a UTF-8 string and removes all non-alphanumeric characters, retaining
only:

- Unicode letters (`\p{L}`)
- Unicode numbers (`\p{N}`)
- Whitespace

If all characters are filtered out, the function retries until a non-empty
string is produced.

## words

    my $str = words(\&ascii_string, 5);

Generates a string consisting of `$n` space-separated "words".

- `$gen` is a coderef that generates a string given a length.
- Each word length is randomly chosen between 1 and 70.
- Words are joined with a single space.

Example:

    words(\&ascii_string, 3);
    # "aZ3 kLm92 Q"

## between

    my $n = between(1, 10);

Returns a random integer between `$min` and `$max` (inclusive).

The distribution is uniform and `$min` must be <= `$max`.

## nullable

    my $value = nullable("data");

Returns either the given value or `undef`.

25% chance of returning `undef`, 75% chance of returning the original value.
Useful for testing optional fields.

## pick

    my $item = pick(qw(a b c));

Returns a random element from the provided list.

If provided an empty list, will return `undef`. Randomness is uniform in
its distribution.

# NOTES

- These functions are not cryptographically secure.
- They are intended for testing, fuzzing, and data generation only.

# AUTHOR

Antonis Kalou <<kalouantonis@protonmail.com>>

# LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See `LICENSE` for details.
