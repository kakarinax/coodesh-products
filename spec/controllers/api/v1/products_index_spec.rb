RSpec.describe Api::V1::ProductsController do
  describe 'GET #index' do
    let(:request) { get :index }

    context 'when there are products' do
      let(:products) { create_list(:product, 20) }

      before do
        products
        request
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all products' do
        expect(response.parsed_body.size).to eq(10)
      end

      it 'paginates the products' do
        expect(response.headers['Current-Page']).to eq('1')
        expect(response.headers['Page-Items']).to eq('10')
      end

      it 'returns second page when param is passed' do
        params = { page: 2 }

        get(:index, params:)

        expect(response.headers['Current-Page']).to eq('2')
      end
    end

    context 'when there are no products' do
      before do
        request
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a message' do
        expect(response.parsed_body['message']).to eq('No products found')
      end
    end
  end
end
