module ExhaustPipe
  class Token
    PADDING = %w(p-8 p-10)
    MARGIN = %w(m-8 m-10)

    # Transpose this hash so we don't have to look up?
    # Use a benchmark
    TYPES = {
      padding: PADDING,
      margin: MARGIN,
    }
  end
end
