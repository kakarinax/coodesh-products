class ImportHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :imported_at, type: DateTime
  field :status, type: String
  field :file_name, type: String
  field :imported_count, type: Integer
  field :error_message, type: String

  embeds_many :products, inverse_of: :import_history
end
