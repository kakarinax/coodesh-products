class ImportFilesWorker
  include Sidekiq::Worker

  def perform
    importer = ImportServices::Importer.new
    history_logger = ImportServices::HistoryLogger.new
    Imports::ImportProductsFileJob.new(importer,
                                       history_logger).perform
  end
end
