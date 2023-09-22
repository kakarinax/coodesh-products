module ImportServices
  class ImportProductsFile
    def initialize(importer, history_logger)
      @importer = importer
      @history_logger = history_logger
    end

    def file_from_url
      response = Faraday.get('https://challenges.coode.sh/food/data/json/index.txt').body
      file_names = response.split("\n")

      file_names.each do |file_name|
        destination_file = Rails.root.join('tmp', file_name)

        next if file_already_imported?(file_name)

        import_status = import_file_and_log(file_name, destination_file)

        @history_logger.send("log_#{import_status}", file_name)
      end
    end

    private

    def import_file_and_log(file_name, destination_file)
      if @importer.import_file(file_name, destination_file)
        'success'
      else
        'failure'
      end
    end

    def file_already_imported?(file_name)
      ImportHistory.where(file_name:).exists?
    end
  end
end
