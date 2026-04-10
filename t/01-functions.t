#!perl
 
use v5.16;
use utf8;
use open qw(:std :encoding(UTF-8));
use Test::More;
use Test::QuickGen;

subtest 'id' => sub {
  is(id(), 0, 'first id is 0');
  is(id(), 1, 'second id is 1');
  is(id(), 2, 'third id is 2');
};

subtest 'string_of' => sub {
  my $s = string_of(20, qw(a b c));
  is(length($s), 20, 'correct length');
  like($s, qr/^[abc]+$/, 'only allowed chars');
};

subtest 'ascii_string' => sub {
  my $s = ascii_string(50);
  is(length($s), 50, 'correct length');
  like($s, qr/^[a-zA-Z0-9_]+$/, 'valid ASCII chars');
};

subtest 'utf8_string' => sub {
  my $s = utf8_string(20);
  ok(length($s) >= 20, 'length >= requested');

  for my $char (split //, $s) {
    my $ord = ord($char);
    ok($ord >= 0x20, "$char is not control char");
    ok(!($ord >= 0xD800 && $ord <= 0xDFFF), "$char is not surrogate");
  }
};

subtest 'utf8_sanitized' => sub {
  my $s = utf8_sanitized(20);
  ok(length($s) > 0, 'not empty');
  like($s, qr/^[\p{L}\p{N}\s]+$/u, 'sanitized chars only');
};

subtest 'between' => sub {
  for (1..1000) {
    my $n = between(5, 10);
    ok($n >= 5 && $n <= 10, "5 <= $n <= 10");
  }
  is(between(3, 3), 3, 'degenerate range');
};

subtest 'pick' => sub {
  my @vals = (1, 2, 3);

  for (1..100) {
    my $v = pick(@vals);
    my $found = grep { $_ == $v } @vals;
    ok($found, "picked value $v is in @vals");
  }
};

subtest 'nullable' => sub {
  my $defined = 0;
  my $undef = 0;

  for (1..1000) {
    my $v = nullable(22);
    defined $v ? $defined++ : $undef++;
  }

  ok($defined > 0, 'sometimes defined');
  ok($undef > 0, 'sometimes undefined');
};

subtest 'words' => sub {
  my $gen = sub { 'x' x $_[0] };
  my $s = words($gen, 5);
  my @words = split ' ', $s;

  is(scalar @words, 5, 'correct number of words');
};

done_testing;
