# NAME

Test::QuickGen

# SYNOPSIS

# DESCRIPTION

Utilities for generating random data.

# FUNCTIONS

## id

    my $new_id = id();
    my $newer_id = id();
    print $new_id == $newer_id; # 0

Generate a program unique ID. Will reset on each program run.

## string\_of

    print string_of(10, qw(a b c d)); # aaabcbdabd

Generate a random string of N length with the given characters.

## ascii\_string

    print ascii_string(10); # aZfjar190a

Generate a random ASCII string of N length.

## utf8\_string

Generate a random UTF-8 string of N length.

## utf8\_sanitized

A clean UTF-8 string that is absent of special characters.

## words

Generate a string of N words, using the string generator `$gen`.

## between

    print between(1, 10); # 1
    print between(1, 10); # 10
    print between(1, 10); # 8

Return a integer between min and max (inclusive).

## nullable

    print nullable(2); # 2
    print nullable(2); # undef

Has a chance of nulling the given value.

## pick

    print pick(1, 2, 3); # 3
    print pick(1, 2, 3); # 1

Pick a random element from a list.
