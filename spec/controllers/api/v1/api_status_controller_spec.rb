RSpec.describe Api::V1::ApiStatusController do
  describe 'GET #index' do
    let(:request) { get :index }

    context 'when api and database are up' do
      let(:expected_response) do
        {
          'db_status' => 'OK'
        }
      end

      let(:mongo_db) { instance_double(Mongo::Client) }

      before do
        allow(Mongoid).to receive(:default_client).and_return(mongo_db)
        allow(mongo_db).to receive(:database).and_return(mongo_db)
        allow(mongo_db).to receive(:command).with(ping: 1).and_return(true)
        request
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns the expected response' do
        expect(response.parsed_body).to eq(expected_response)
      end
    end

    context 'when api is up but database is down' do
      let(:mongo_db) { instance_double(Mongo::Client) }

      before do
        allow(Mongoid).to receive(:default_client).and_return(mongo_db)
        allow(mongo_db).to receive(:database).and_return(mongo_db)
        allow(mongo_db).to receive(:command).with(ping: 1).and_raise(Mongo::Error::NoServerAvailable)
        request
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns the expected response' do
        expect(response.parsed_body).not_to be({ 'db_status' => 'OK' })
      end
    end
  end
end
