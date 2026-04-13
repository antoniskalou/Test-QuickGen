# Contribute

Run this file with markatzea to configure your git hooks [markatzea][markatzea].
The githook will then run this file for you using markatzea.

## Documentation

Generate the README.md

```bash bash
pod2markdown ./lib/Test/QuickGen.pm > ./README.md
```

## Tests

Running tests

```bash bash
prove
```

## Git Hook

A pre-commit hook to update the docs.

```bash cat - > .git/hooks/pre-commit
#!/usr/bin/env bash

markatzea ./CONTRIBUTE.md
git add README.md
```

Make the script executable

```bash bash
chmod +x .git/hooks/pre-commit
```

[markatzea]:https://github.com/bas080/markatzea
