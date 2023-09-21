require 'swagger_helper'

RSpec.describe 'api/v1/products' do
  path '/api/v1/products' do
    get('list products') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let(:products) { create_list(:product, 10) }
        schema type: :array,
               items: {
                 '$ref' => '#/components/schemas/product'
               }

        before do
          products
        end

        run_test!
      end

      response(404, 'not found') do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        run_test!
      end
    end
  end
end
