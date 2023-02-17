# frozen_string_literal: true

require_relative "char_rules"
require_relative "quecto_error"
require_relative "token"
require_relative "token_types"

#
# Performs lexical analysis of a given string.
#
class Lexer
  include TokenTypes
  include CharRules

  #
  # Initialize a lexer instance.
  #
  # @param [String] str
  #   String to parse.
  #
  def initialize(str)
    @str = str
    @pos = 0
    @cur_char = nil

    _next_char
  end

  #
  # Create a list of tokens from a string.
  #
  # @return [Array<Token>] tokens
  #
  # @raise [IllegalCharError]
  #   Raises when @str has an unsupported character.
  #
  def build_tokens
    tokens = []

    until @cur_char.nil?
      if @cur_char == ADD_CHAR
        tokens.append(Token.new(type: TT_PLUS))
      elsif @cur_char == SUB_CHAR
        tokens.append(Token.new(type: TT_MINUS))
      elsif @cur_char.match?(NUM_CHAR)
        num = Token.new(type: TT_INT, value: _build_word(NUM_CHAR).to_i)
        tokens.append(num)
      elsif @cur_char.match?(CONST_FIRST_CHAR)
        num = Token.new(type: TT_CONST, value: _build_word(CONTS_CHAR))
        tokens.append(num)
      elsif @cur_char.match?(IGNOR_CHAR)
        # Ignore whitespace.
      else
        error_msg = "illegal character '#{@cur_char}' at the position: #{@pos - 1}"
        raise IllegalCharError, error_msg
      end
      _next_char
    end

    tokens.append(Token.new(type: TT_EOF))

    tokens
  end

  private

  #
  # Build a 'word' out of a sequence of characters.
  #
  # A 'word' is a sequence of characters followed one by another without break characters (e.g. a space or a supported
  # math operator: '+', '-', etc).
  #
  # A 'word' could be represented in a form of:
  #
  # 1. a sequence of alphabetical characters optionally mixed with digits and joined into one string using a connective
  # character '_'. Examples:
  #   - 'ruby' (a sequence of alphabetical characters only);
  #   - 'foobar9000' (a mix of alphabetical characters and digits);
  #   - 'this_is_a_3rd_example' (long string joined with a connective character).
  #
  # 2. an integer number, e.g.: '31337' (a sequence of digits without break characters).
  #
  # @param [Regexp] regexp
  #   Defines that kind of character sequence the method should be looking for: NUM_CHAR (search for a digit) or
  #   CONTS_CHAR (search for a constant).
  #
  # @return [String] word
  #
  def _build_word(regexp)
    word = ""

    until @cur_char.nil?
      break unless @cur_char.match?(regexp)

      word += @cur_char
      _next_char
    end
    _next_char

    @pos -= 1
    word
  end

  #
  # Process next character in the string.
  #
  def _next_char
    @cur_char = @pos < @str.length ? @str[@pos] : nil
    @pos += 1
  end
end
