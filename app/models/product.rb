class Product
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps

  enum status: %i[draft published trash], null: false
  field :imported_t, type: DateTime, null: false
  field :code, type: Integer
  field :url, type: String
  field :creator, type: String
  field :product_name, type: String
  field :quantity, type: String
  field :brands, type: String
  field :categories, type: String
  field :labels, type: String
  field :cities, type: String
  field :purchase_places, type: String
  field :stores, type: String
  field :ingredients_text, type: String
  field :traces, type: String
  field :serving_size, type: String
  field :serving_quantity, type: Float
  field :nutriscore_score, type: Integer
  field :main_category, type: String
  field :image_url, type: String
end
