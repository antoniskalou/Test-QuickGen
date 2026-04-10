use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Test::QuickGen',
  AUTHOR => [
    'Antonis Kalou <kalouantonis@protonmail.com>',
  ],
  LICENSE => 'perl_5',
  VERSION_FROM => 'lib/Test/QuickGen.pm',
  EXE_FILES => ['bin/quicktest'],
  MIN_PERL_VERSION => '5.16.0',
  TEST_REQUIRES => {
    'Test::More' => 0,
  }
);
