# Turbo::Ruby

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add turbo-ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install turbo-ruby

## Note: Usage in Rails

In order to use `turbo-ruby` in Rails with the Rails `render` method you have to install the `phlex-rails` gem in your app.

### Regular Element

```ruby
# Ruby
Turbo::Elements::TurboStream.new(action: "console_log", message: "Hello World").to_html
```

```html+erb
<!-- Rails -->
<%= render Turbo::Elements::TurboStream.new(action: "console_log", message: "Hello World") %>
```



### Blocks

```ruby
# Ruby
Turbo::Elements::TurboStream.new(action: "morph", target: "post_1") do
  %(<div id="post_id">
      <h1>Post 1</h1>
    </div>)
end.to_html
```

```html+erb
<!-- Rails -->
<%= render Turbo::Elements::TurboStream.new(action: "morph", target: "post_1") do %>
  <div id="post_id">
    <h1>Post 1</h1>
  </div>
<% end %>
```

### Partials (Rails only)

```html+erb
<!-- Rails -->
<%= render turbo.morph(@post, partial: "posts/post") %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcoroth/turbo-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/marcoroth/turbo-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Turbo::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/marcoroth/turbo-ruby/blob/main/CODE_OF_CONDUCT.md).
