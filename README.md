# Example Linter

Check the code examples in your markdown.

## Installation

```
% cabal install ex-lint
```

*Note: not yet on Hackage, install from source for now*

## Usage

Format examples in your markdown like [this][ex].

[ex]: https://github.com/pbrisbin/ex-lint/blob/master/test/example.md

Run the markdown file with the linter to see any errors:

```
% ex-lint test/example.md
Mismatch in example
  Expression: 2 + 2
  Expected:   5
  Actual:     4
```

If no files are passed, markdown is read from `stdin`.

## TODO

- Exit non-zero if mismatches present
- Hide `stderr` from check command
- Add `CompileError` to `CheckResult`, ignore those
- Output filename on mismatches
- Output line number on mismatches (difficult)
