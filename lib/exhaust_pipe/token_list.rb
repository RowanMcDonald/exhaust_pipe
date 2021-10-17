module ExhaustPipe
  class TokenList
    def initialize(*classes)
      @tokens = classes
      @parsed = {}

      # Should we even parse these if we're not going to use them?
      Token::TYPES.each do |k, types|
        @parsed[k] = types & classes
      end

      validate_parsed_tokens!

      @parsed[:unknown] = @parsed.values.flatten - classes
    end

    def to_s
      @tokens.map(&:to_s).join(" ")
    end
    alias to_str to_s

    def ==(other)
      to_str == other
    end

    def add(*new_tokens)
      new_tokens.each do |new_token|
        @tokens << new_token
      end

      Token::TYPES.each do |k, types|
        addition = types & new_tokens
        @parsed[k] = @parsed[k] + addition
      end

      validate_parsed_tokens!

      self
    end

    def override(*new_tokens)
      Token::TYPES.each do |k, types|
        addition = types & new_tokens
        @parsed[k] = addition if addition.any?
      end

      @tokens = @parsed.values.flatten

      self
    end

    private

    def validate_parsed_tokens!
      return unless ExhaustPipe.raise_error?

      @parsed.each do |category, tokens|
        if tokens[1]
          raise TokenConflictError.new(
            "Only one #{category} token can be added. Classes #{tokens} conflict, please remove one of them.",
          )
        end
      end
    end
  end
end
