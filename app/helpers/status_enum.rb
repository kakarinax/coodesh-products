class StatusEnum
  extend MongoEnum

  MAPPING = {
    'draft' => 'draft',
    'trash' => 'trash',
    'published' => 'published'
  }.freeze
end
