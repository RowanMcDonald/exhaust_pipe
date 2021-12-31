# Exhaust Pipe

A helper library for managing tailwind class lists. Intended for use in component based rails applications. The examples here use [view_component](https://github.com/github/view_component), but this should be applicable to any component system.

## The problem at hand
A common issue that you encounter using tailwind in a component based application is class conflicts. Say you have a component "Box" that has a default margin and you allow passing in classes that will be applied to your component. Someone passes in a margin class. What happens?

```rb
class BoxComponent < ViewComponent::Base
  def initialize(classes:)
    @classes = classes
  end
end

# <div class="m-4 <%= @classes %">><%= content %></div>
```

Your user passes in "m-8":
```erb
<%= render BoxComponent.new(classes: "m-8") do %>
  <p>My content</p>
<% end %>
```

This results in the following html
```html
<div class="m-4 m-8">
  <p>My content</p>
</div>
```
## So what happens?
That's a good question. What happens today is that both the `.m-4` and `.m-8` css rules are applied to the element and the one with the highest specificity "wins".  The rule with the highest specificity in this case is `.m-8` and thus the element has a 2rem margin - the margin applied by the `.m-8` rule.

If we pass in a `m-0` class, the `.m-4` rule has the highest specificity and that rule is applied.

Why does the `m-8` class win when it's passed in, but `m-0` not? This is because the `.m-8` rule is defined after the `.m-4` rule, which is defined after the `.m-0` rule.

This behavior is described in a github issue here: https://github.com/tailwindlabs/tailwindcss/issues/1010

## What is the problem with this behavior?
1. It fails silently.
   1. Unnecessary classes make it past code review
   2. Developers have to root out the conflict themselves.

2. It isn't friendly to component based applications. In component based applications, we often want to allow developers to merge style lists. We want to be able to support two behaviors:
   1. Merge and raise errors about conflicts
   2. Merge and override the style (e.g. when we pass in the `m-0` class, we want to remove the `m-4` class.

Side note, in Tailwind play, a warning will allert you to the cssConflict in the div above. I wish there was a tool to surface this via static analysis. (Although this is tricky b/c whatever tool you use has to understand your component system.)

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

### Overriding a class in a token list

Sometimes, you will have a defined list of base styles (say in a component) but you'll want the user to be able to override a given style.

```rb
tailwind("bg-red-100", "m-10").override("m-12")
# => ExhaustPipe::TokenList("bg-red-100 m-12")
```


### Usage with the view_component library

TODO
## Configuration

In certain environments (like production), you may want to turn off raising errors because a TokenConflictError is not important enough to raise.

```rb
ExhaustPipe.raise_errors = false
```

## TODO
1. Benchmark
1. Allow adding custom classes
1. Support all default tailwind classes
1. Add a section describing usage with the view component library
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RowanMcDonald/exhaust_pipe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/RowanMcDonald/exhaust_pipe/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ExhaustPipe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/RowanMcDonald/exhaust_pipe/blob/main/CODE_OF_CONDUCT.md).
