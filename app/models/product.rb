class Product
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps

  enum :status, %i[draft trash published], null: false
  field :imported_t, type: DateTime, null: false
  field :code, type: Integer
  field :url, type: String
end
