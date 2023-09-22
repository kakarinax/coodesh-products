class ImportFilesWorker
  include Sidekiq::Worker

  def perform
    importer = ImportServices::Importer.new
    history_logger = ImportServices::HistoryLogger.new
    ImportServices::ImportProductsFile.new(importer,
                                           history_logger).file_from_url
  end
end
