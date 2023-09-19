RSpec.describe Product, type: :model do
  describe 'validations' do
    it { is_expected.to have_field(:status).of_type(StatusEnum) }
    it { is_expected.to have_field(:imported_t).of_type(DateTime) }

    it 'validates presence os status and imported_t' do
      is_expected.to validate_presence_of(:status)
      is_expected.to validate_presence_of(:imported_t)
    end

    context 'when product is created' do
      let(:product) { create(:product) }

      it 'has status and imported_t' do
        expect(product.status).not_to be_nil
        expect(product.imported_t).not_to be_nil
      end
    end
  end
end
