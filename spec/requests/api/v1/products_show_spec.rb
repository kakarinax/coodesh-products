require 'swagger_helper'

RSpec.describe 'api/v1/products/{code}' do
  path '/api/v1/products/{code}' do
    get('show product') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :code, in: :path, type: :integer, required: true

      response(200, 'successful') do
        let(:product) { create(:product) }
        let(:code) { product.code }
        schema '$ref' => '#/components/schemas/product'

        before do
          product
        end

        run_test!
      end

      response(404, 'not found') do
        let(:code) { 0 }
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        run_test!
      end
    end
  end
end
