module Imports
  class ImportProductsFileJob < ApplicationJob
    queue_as :default

    def initialize(importer, history_logger)
      @importer = importer
      @history_logger = history_logger

      super
    end

    def perform(*_args)
      MemoryProfiler.start
      start_time = Time.current
      response = Faraday.get('https://challenges.coode.sh/food/data/json/index.txt').body
      file_names = response.split("\n")

      file_names.each do |file_name|
        destination_file = Rails.root.join('tmp', file_name)

        next if file_already_imported?(file_name)

        import_status = import_file_and_log(file_name, destination_file)

        execution_time_and_log(start_time, import_status, file_name)

        save_products(destination_file) if import_status == 'success'

        save_memory_usage
      end
    end

    private

    def execution_time_and_log(start_time, import_status, file_name)
      end_time = Time.current
      cron_execution_time = end_time - start_time
      @history_logger.send("log_#{import_status}", file_name, cron_execution_time)
    end

    def save_memory_usage
      report = MemoryProfiler.stop

      report = report.total_allocated_memsize.to_s
      import_history = ImportHistory.last

      import_history.update!(memory_usage: report)
    end

    def import_file_and_log(file_name, destination_file)
      if @importer.import_file(file_name, destination_file)
        'success'
      else
        'failure'
      end
    end

    def file_already_imported?(file_name)
      ImportHistory.where(file_name:, status: 'success').exists?
    end

    def save_products(destination_file)
      ImportServices::GetProductsFromFile.new.decompress_data(destination_file) if destination_file
    end
  end
end
