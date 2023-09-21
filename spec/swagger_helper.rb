# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Development server'
        },
        {
          url: 'http://test.host/api/v1',
          description: 'Test server'
        }
      ],
      components: {
        schemas: {
          product: {
            type: :object,
            properties: {
              _id: { type: :object,
                     properties: {
                       oid: { type: :string }
                     } },
              code: { type: :integer },
              imported_t: { type: :string, format: :date_time },
              status: { type: :string },
              url: { type: :string },
              creator: { type: :string },
              product_name: { type: :string },
              quantity: { type: :string },
              brands: { type: :string },
              categories: { type: :string },
              labels: { type: :string },
              cities: { type: :string },
              purchase_places: { type: :string },
              stores: { type: :string },
              ingredients_text: { type: :string },
              traces: { type: :string },
              serving_size: { type: :string },
              serving_quantity: { type: :number },
              nutriscore_score: { type: :integer },
              main_category: { type: :string },
              image_url: { type: :string }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.

  config.swagger_format = :yaml
end
