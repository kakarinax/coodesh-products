module ImportServices
  class HistoryLogger
    def log_success(file_name)
      ImportHistory.create!(imported_at: DateTime.now,
                            status: 'success',
                            file_name:,
                            imported_count: Product.count)
    end

    def log_failure(file_name)
      ImportHistory.create!(imported_at: DateTime.now, status: 'failure', file_name:)
    end
  end
end
