class StatusEnum
  extend MongoEnum

  MAPPING = {
    'draft' => 'draft',
    'trash' => 'trash',
    'published' => 'published'
  }.freeze

  def self.options
    MAPPING.keys
  end

  def self.error_message(value)
    return if value.include?(options)

    raise ArgumentError, "must be one of: #{options.join(', ')}"
  end
end
