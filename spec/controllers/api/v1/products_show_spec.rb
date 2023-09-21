RSpec.describe Api::V1::ProductsController do
  describe 'GET #show' do
    let(:request) { get :show, params: { code: } }

    context 'when the product exists' do
      let(:product) { create(:product) }
      let(:code) { product.code }

      before do
        request
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the product' do
        expect(response.parsed_body['code']).to eq(product.code)
      end
    end

    context 'when the product does not exist' do
      let(:code) { 'invalid_code' }

      before do
        request
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a message' do
        expect(response.parsed_body['message']).to eq('Product not found')
      end
    end
  end
end
