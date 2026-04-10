# NAME

Test::QuickGen

# SYNOPSIS

# DESCRIPTION

Utilities for generating random data.

# FUNCTIONS

## id

Generate a program unique ID. Will reset on each program run.

## string\_of

Generate a random string of N length with the given characters.

## ascii\_string

Generate a random ASCII string of N length.

## utf8\_string

Generate a random UTF-8 string of N length.

## utf8\_sanitized

A clean UTF-8 string that is absent of special characters.

## words

Generate a string of N words, using the string generator `$gen`.

## between

Return a integer between min and max (inclusive).

## nullable

Has a chance of nulling the given value.

## pick

Pick a random element from a list.
