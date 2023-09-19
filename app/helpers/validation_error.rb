class ValidationError < StandardError
  def initialize(message = 'Validation error')
    super(message)
  end
end
