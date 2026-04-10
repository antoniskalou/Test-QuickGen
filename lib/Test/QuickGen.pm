package Test::QuickGen;

use v5.40;
use Exporter 'import';

our $VERSION = '0.1.0';

our @EXPORT = qw(
  ascii_string between id string_of pick nullable words
  utf8_string utf8_sanitized
);

=head1 NAME

Test::Random

=head1 SYNOPSIS

=head1 DESCRIPTION

Utilities for generating random data.

=head2 id

Generate a program unique ID. Will reset on each program run.

=cut

sub id {
    state $id = 0;
    $id++;
}

=head2 string_of

Generate a random string of N length with the given characters.

=cut

sub string_of ($n, @chars) {
  my $str;
  for (1..$n) {
    $str .= $chars[rand @chars];
  }
  $str;
}

=head2 ascii_string

Generate a random ASCII string of N length.

=cut

sub ascii_string ($n) {
  string_of($n, 'a'..'z', 'A'..'Z', '0'..'9', '_');
}

=head2 utf8_string

Generate a random UTF-8 string of N length.

=cut

sub utf8_string ($n) {
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

sub utf8_sanitized ($n) {
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

sub words ($gen, $n) {
  my @words = map { $gen->(between(1, 70)) } (1..$n);
  join ' ', @words;
}

=head2 between

Return a integer between min and max (inclusive).

=cut

sub between ($min, $max) {
  $min + int(rand($max - $min + 1));
}

=head2 nullable

Has a chance of nulling the given value.

=cut

sub nullable ($val) {
  if (rand() < 0.25) {
    undef;
  } else {
    $val;          
  }
}

=head2 pick

Pick a random element from a list.

=cut

sub pick { $_[rand @_] }

1;
