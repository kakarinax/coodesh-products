RSpec.describe Imports::ImportProductsFileJob do
  let(:importer) { instance_double(ImportServices::Importer) }
  let(:history_logger) { instance_double(ImportServices::HistoryLogger) }
  let(:job) { described_class.new(importer, history_logger) }
  let(:get_products_from_file) { instance_double(ImportServices::GetProductsFromFile) }

  include_context 'when requesting file'

  describe '#perform' do
    context 'when file is imported successfully' do
      before do
        allow(importer).to receive(:import_file).and_return(true)
        allow(history_logger).to receive(:send)
        allow(ImportServices::GetProductsFromFile).to receive(:new).and_return(get_products_from_file)
        allow(get_products_from_file).to receive(:decompress_data)
      end

      it 'jobs perform successfully' do
        expect { job.perform }.not_to raise_error
      end

      it 'calls importer to import file' do
        job.perform
        expect(importer).to have_received(:import_file).twice
        expect(history_logger).to have_received(:send).with('log_success', 'file1.txt').once
        expect(history_logger).to have_received(:send).with('log_success', 'file2.txt').once
      end
    end

    context 'when files are already imported' do
      let(:import_history) { create(:import_history, file_name: 'file1.txt') }

      before do
        import_history
        allow(importer).to receive(:import_file).and_return(true)
        allow(history_logger).to receive(:send)
        allow(ImportServices::GetProductsFromFile).to receive(:new).and_return(get_products_from_file)
        allow(get_products_from_file).to receive(:decompress_data)
        job.perform
      end

      it 'only imports files that are not imported yet' do
        expect(importer).to have_received(:import_file).once
        expect(history_logger).to have_received(:send).with('log_success', 'file2.txt').once
      end
    end

    context 'when perform successfully and call Service' do
      before do
        allow(importer).to receive(:import_file).and_return(true)
        allow(history_logger).to receive(:send)
        allow(ImportServices::GetProductsFromFile).to receive(:new).and_return(get_products_from_file)
        allow(get_products_from_file).to receive(:decompress_data)
        job.perform_now
      end

      it 'calls GetProductsFromFile to decompress data' do
        expect(get_products_from_file).to have_received(:decompress_data).twice
      end
    end
  end
end
