RSpec.describe ImportServices::GetProductsFromFile do
  describe 'save products' do
    context 'when save products successfully' do
      let(:service) { described_class.new }
      let(:batch) do
        [
          { 'code' => '123', 'product_name' => 'Product 1', 'status' => 'draft',
            'imported_t' => '2020-01-01T00:00:00Z' },
          { 'code' => '456', 'product_name' => 'Product 2', 'status' => 'published',
            'imported_t' => '2020-01-01T00:00:00Z' }
        ]
      end

      before do
        service.save_products_in_bulks(batch)
      end

      it 'saves products to the database' do
        expect(Product.count).to eq(2)

        # Você também pode verificar se os produtos específicos foram salvos corretamente
        expect(Product.where(code: '123')).to be_exists
        expect(Product.where(code: '456')).to be_exists
      end
    end
  end
end
