# ActionExtractor

Arguments extractor for Rails actions.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'action_extractor'
```

And then execute:

```shell
bundle install
```

## Usage

```ruby
class ArticlesController < ApplicationController
  extract(
    article_id: {
      from: :path,
      schema: {
        type: 'integer',
      },
    },
    body: {
      from: :form_data,
      schema: {
        type: 'string',
      },
    },
    request_id: {
      from: :header,
      name: 'X-Request-Id',
      schema: {
        format: 'uuid',
        type: 'string',
      },
    },
    title: {
      from: :form_data,
      schema: {
        type: 'string',
      },
    },
  ).on \
  def update(
    article_id:,
    body:,
    request_id:,
    title:
  )
    article = Article.find(article_id)
    if article.update(
      body: body,
      title: title,
      request_id: request_id,
    )
      redirect_to article
    else
      @article = article
      render :edit, status: 400
    end
  end
end
```

## Acknowledgements

This gem was inspired by the following gems:

- [asakusarb/action_args](https://github.com/asakusarb/action_args)
- [r7kamura/weak_parameters](https://github.com/r7kamura/weak_parameters)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
