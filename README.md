# QuectoCalc

A simple calculator that evaluates primitive arithmetic expressions represented in a text form, simular to the Ruby's native method _eval_.

Although QuectoCalc could perform only a _very_ limited set of operations, it parses input expressions in a way that resembles a run of a real interpreter. QuectoCalc performs lexical analysis, builds an abstract syntax tree (AST), and then evaluates the expression based on the AST. Thus, it’s functionality could be expanded later on.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quecto_calc'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install quecto_calc

## Usage

obj.evaluate(expression [, constants]) -> result

#### Arguments

+ _expression_ [String]

    Expression to evaluate.

+ _constants_ [Hash{ String => Numeric }]

    Constant names and their respective values.

#### Returns

+ _result_ [Numeric]

## Supported operators

+ _-_

    Subtraction.

+ _+_ 

    Addition.

## Examples:

```ruby
require "quecto_calc"

calc = QuectoCalc.new

# Evaluate an expression:
calc.evaluate("1 + 2 + 3 + 4 + 5 - 6") # => 9

# Evaluate an expression with constants:
foo = 9000
bar = 1234
calc.evaluate("foo - bar", { "foo" => foo, "bar" => bar }) # => 7766
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/quecto_calc.

## Acknowledges

The lexer and the parser were inspired by the David Callanan's "[Make Your Own Programming Language](https://github.com/davidcallanan/py-myopl-code)" series.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
