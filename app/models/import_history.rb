class ImportHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :imported_at, type: DateTime
  field :status, type: String
  field :file_name, type: String
  field :error_message, type: String
  field :cron_execution_time, type: DateTime
  field :memory_usage, type: String

  embeds_many :products, inverse_of: :import_history
end
