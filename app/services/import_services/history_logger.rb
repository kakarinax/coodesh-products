module ImportServices
  class HistoryLogger
    def log_success(file_name, cron_execution_time)
      ImportHistory.create!(imported_at: DateTime.now,
                            status: 'success',
                            file_name:,
                            cron_execution_time:)
    end

    def log_failure(file_name)
      ImportHistory.create!(imported_at: DateTime.now,
                            status: 'failure', file_name:,
                            cron_execution_time:,
                            error_message: 'Error importing file')
    end
  end
end
