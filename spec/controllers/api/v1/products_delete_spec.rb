RSpec.describe Api::V1::ProductsController do
  describe 'PATCH #delete' do
    let(:request) { patch :delete, params: { code: } }

    context 'when the product exists' do
      let(:product) { create(:product) }
      let(:code) { product.code }

      before do
        request
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a message' do
        expect(response.parsed_body['message']).to eq('Product deleted')
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

    context 'when the product could not be deleted' do
      let(:product) { create(:product) }
      let(:code) { product.code }
      let(:product_double) { instance_double(Product) }

      before do
        allow(Product).to receive(:find_by).and_return(product_double)
        allow(product_double).to receive(:update!).and_return(false)
        request
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a message' do
        expect(response.parsed_body['message']).to eq('Product could not be deleted')
      end
    end
  end
end
