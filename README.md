# Example Linter

Check the code examples in your markdown.

## Installation

```
% cabal install ex-lint
```

## Usage

Add expected results in your markdown, like so:

````md
This is some markdown. Here is a good example:

```hs
add x y = x + y

add 2 2
-- => 4
```

And here is a bad example:

```hs
add x y = x + y

add 2 2
-- => 5
```
````

Run the markdown file through your linter and see errors

```
% ex-lint foo.md
foo.md - error in example
  Example expression: add 2 2
  Expected result:    5
  Actual result:      4
````

*Actual error messages are subject to change*

## Limitations

This tool is in its early stages and quite simple at the moment:

- One example per code block
- The example expression must be a single line
- The expected result must be a single line and immediately follow the example
  expression
