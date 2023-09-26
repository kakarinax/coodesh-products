require 'swagger_helper'

RSpec.describe 'api/v1/api_status' do
  path '/api/v1' do
    get('list api_status and db status') do
      tags 'ApiStatus'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 db_status: { type: :string }
               }

        run_test!
      end

      response(500, 'internal server error') do
        schema type: :object,
               properties: {
                 db_status: { type: :string }
               }

        xit # skipped, it's just to keep in the documentation
      end
    end
  end
end
