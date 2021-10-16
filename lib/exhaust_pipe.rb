require_relative "exhaust_pipe/version"

module ExhaustPipe
  class Error < StandardError; end

  def tailwind(*args)
    tag_values = []

    args.each do |tag_value|
      case tag_value
      when Hash
        tag_value.each do |key, val|
          tag_values << key.to_s if val && key.present?
        end
      when Array
        tag_values.concat build_tag_values(*tag_value)
      else
        # tag_values << tag_value.to_s if tag_value.present?
        tag_values << tag_value.to_s
      end
    end

    tokens = tag_values.flat_map { |value| value.to_s.split(/\s+/) }.uniq
    tokens.join(" ")
  end
  module_function :tailwind
end
