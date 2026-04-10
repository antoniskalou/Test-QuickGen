package Test::QuickGen;

use v5.16;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '0.1.0';

our @EXPORT = qw(
  ascii_string between id string_of pick nullable words
  utf8_string utf8_sanitized
);

=head1 NAME

Test::QuickGen

=head1 SYNOPSIS

=head1 DESCRIPTION

Utilities for generating random data.

=head1 FUNCTIONS

=head2 id

  my $new_id = id();
  my $newer_id = id();
  print $new_id == $newer_id; # 0

Generate a program unique ID. Will reset on each program run.

=cut

sub id {
    state $id = 0;
    $id++;
}

=head2 string_of

  print string_of(10, qw(a b c d)); # aaabcbdabd

Generate a random string of N length with the given characters.

=cut

sub string_of {
  my ($n, @chars) = @_;
  my $str;
  for (1..$n) {
    $str .= $chars[rand @chars];
  }
  $str;
}

=head2 ascii_string

  print ascii_string(10); # aZfjar190a

Generate a random ASCII string of N length.

=cut

sub ascii_string {
  my ($n) = @_;
  string_of($n, 'a'..'z', 'A'..'Z', '0'..'9', '_');
}

=head2 utf8_string

Generate a random UTF-8 string of N length.

=cut

sub utf8_string {
  my ($n) = @_;
  my $str = '';
  while (length($str) < $n) {
    # skip non-visible ASCII characters (0x00-0x19)
    # include everything up to 0x2FFF (extended UTF-8)
    my $code_point = between(0x20, 0x2FFF);

    # skip problematic unicode points
    next if ($code_point >= 0xD800 && $code_point <= 0xDFFF); # surrogate pairs
    next if ($code_point >= 0xFDD0 && $code_point <= 0xFDEF); # non characters
    # also non characters
    next if ($code_point % 0x10000 == 0xFFFE || $code_point % 0x10000 == 0xFFFF);
    next if ($code_point >= 0x7F && $code_point <= 0x9F); # control characters

    $str .= chr($code_point);
  }
  $str;
}

=head2 utf8_sanitized

A clean UTF-8 string that is absent of special characters.

=cut

sub utf8_sanitized {
  my ($n) = @_;
  my $s = utf8_string($n);
  $s =~ s/[^\p{L}\p{N}\s]//gu;

  # sometimes all characters get filtered, try again and hope for the best
  if ($s eq '') {
    return utf8_sanitized($n);
  }

  $s;
}

=head2 words

Generate a string of N words, using the string generator C<$gen>.

=cut

sub words {
  my ($gen, $n) = @_;
  my @words = map { $gen->(between(1, 70)) } (1..$n);
  join ' ', @words;
}

=head2 between

  print between(1, 10); # 1
  print between(1, 10); # 10
  print between(1, 10); # 8

Return a integer between min and max (inclusive).

=cut

sub between {
  my ($min, $max) = @_;
  $min + int(rand($max - $min + 1));
}

=head2 nullable

  print nullable(2); # 2
  print nullable(2); # undef

Has a chance of nulling the given value.

=cut

sub nullable {
  my ($val) = @_;
  if (rand() < 0.25) {
    undef;
  } else {
    $val;          
  }
}

=head2 pick

  print pick(1, 2, 3); # 3
  print pick(1, 2, 3); # 1

Pick a random element from a list.

=cut

sub pick { $_[rand @_] }

1;
