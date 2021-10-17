require_relative "exhaust_pipe/version"
require_relative "exhaust_pipe/token"
require_relative "exhaust_pipe/token_list"

module ExhaustPipe
  class TokenConflictError < StandardError; end

  module_function

  def tailwind(*classes)
    TokenList.new(*classes)
  end

  def raise_error=(value)
    @raise_error = value
  end

  def raise_error?
    @raise_error
  end
end

ExhaustPipe.raise_error = true
