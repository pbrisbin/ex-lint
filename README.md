# Example Linter

Check the code examples in your markdown.

## Installation

```
% cabal install ex-lint
```

*Note: not yet on Hackage, install from source for now*

## Usage

Format examples in your markdown like so:

````md
This is some markdown. Here is a good example:

```hs
add x y = x + y

add 2 2
-- => 4
```

And here is an incorrect example:

```hs
add x y = x + y

add 2 2
-- => 5
```
````

Run the markdown file with the linter to see any errors:

```
% ex-lint test/example.md
Mismatch in example
  Expression: 2 + 2
  Expected:   5
  Actual:     4
```

If no files are passed, markdown is read from `stdin`.
