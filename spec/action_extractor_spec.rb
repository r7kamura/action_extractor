# frozen_string_literal: true

class TestApp < Rails::Application
  config.hosts << ::ActionController::Renderer::DEFAULTS[:http_host]

  routes.draw do
    patch '/articles/:id', to: 'articles#update'
  end
end

Rails.logger = Logger.new(nil)

class ArticlesController < ActionController::Base
  extract(
    article_id: {
      from: :path,
      name: 'id',
      schema: {
        type: 'integer'
      }
    },
    body: {
      from: :form_data,
      schema: {
        type: 'string'
      }
    },
    debug: {
      from: :query,
      schema: {
        type: 'integer'
      }
    },
    request_id: {
      from: :header,
      name: 'X-Request-Id',
      schema: {
        format: 'uuid',
        type: 'string'
      }
    },
    title: {
      from: :form_data,
      schema: {
        type: 'string'
      }
    }
  ).on \
    def update(**args)
      render(json: args)
    end
end

require 'json'

RSpec.describe ActionExtractor do
  include Rack::Test::Methods

  let(:app) do
    Rails.application
  end

  let(:headers) do
    {
      'X-Request-Id' => '421e48b6-5034-4cac-b429-3030fe951c06'
    }
  end

  let(:query_parameters) do
    {
      'debug' => '1'
    }
  end

  let(:request_parameters) do
    {
      'body' => 'dummy body',
      'title' => 'dummy title'
    }
  end

  it 'extends controller so that actions take keyword arguments' do
    patch(
      "/articles/1?#{query_parameters.to_query}",
      request_parameters,
      headers.transform_keys { |key| "HTTP_#{key.gsub('-', '_').upcase}" }
    )
    expect(
      JSON.parse(last_response.body)
    ).to eq(
      query_parameters.merge(request_parameters).merge(
        'article_id' => '1',
        'request_id' => headers['X-Request-Id']
      )
    )
  end
end
