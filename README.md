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

### `.extract(...).on(action_name)`

By using this DSL method, we can state what kind of input value the subsequent action is expecting.

Note that the argument names passed here will also be used at the action call.

### `:from`

This value represents where the data is comming from.

Supported values are:

- `:form_data`
    - Extract data while assuming the request body is encoded from form data.
- `:header`
    - Extract data from HTTP request header.
- `:path`
    - Extract data from URL path parameters.
- `:query`
    - Extract data from URL query parameters.

### `:name`

This value represents what name of value to extract from the data source.

In many cases, this option is not necessary because the argument name is used as the key for extraction instead.
This is useful for the case when the names overlap or when extracting from data source with different naming convention (e.g. HTTP headers).

### `:schema`

It's currently unfinished, but we intend to use this value for the following purposes:

- Validate input values with OpenAPI compatible implementation
- Provide metadata that can be used to generate OpenAPI document

## Acknowledgements

This gem was inspired by the following libraries:

- [actix/actix-web](https://github.com/actix/actix-web)
- [asakusarb/action_args](https://github.com/asakusarb/action_args)
- [r7kamura/weak_parameters](https://github.com/r7kamura/weak_parameters)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
