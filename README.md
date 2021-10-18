# Exhaust Pipe

A helper library for managing tailwind class lists. 

This gem solves a couple problems you encounter working with tailwind.
TODO: write up the issues with class conflict and surprising specificity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exhaust_pipe'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install exhaust_pipe

## Usage

### Generating a class list with the `tailwind` method

```rb
include ExhaustPipe

tailwind("bg-red-100", "m-10")
# => ExhaustPipe::TokenList("bg-red-100 m-10")
```

### Adding to a token list
```rb
classes = tailwind("bg-red-100", "m-10")
# => ExhaustPipe::TokenList("bg-red-100 m-10")

classes.add("w-10")
# => ExhaustPipe::TokenList("bg-red-100 m-10 w-10")
```

If you add a class that will conflict with another class in the list it will raise an error (this is configurable

```rb
tailwind("bg-red-100", "m-10").add("m-12")
# => ExhaustPipe::TokenConflictError
```

### Overriding a class in a classlist

Sometimes, you will have a defined list of base styles (say in a component) but you'll want the user to be able to override a given style.

```rb
tailwind("bg-red-100", "m-10").override("m-12")
# => ExhaustPipe::TokenList("bg-red-100 m-12")
```

## Configuration

```rb
ExhaustPipe.raise_errors = false
```

## TODO
1. Benchmark
1. Allow adding custom classes
1. Support all default tailwind classes
1. Specify use cases


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RowanMcDonald/exhaust_pipe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/exhaust_pipe/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ExhaustPipe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/RowanMcDonald/exhaust_pipe/blob/main/CODE_OF_CONDUCT.md).
