module MongoEnum
  # Takes application-scope value and converts it to how it would be
  # stored in the database. Converts invalid values to nil.
  def mongoize(object)
    value = mapping[object]
    raise ValidationError, "must be one of: #{mapping.keys.join(', ')}" unless value

    value
  end

  # Get the value as it was stored in the database, and convert to
  # application-scope value. Converts invalid values to nil.
  def demongoize(object)
    value = inverse_mapping[object]
    raise ValidationError, "must be one of: #{mapping.keys.join(', ')}" unless value

    value
  end

  # Converts the object that was supplied to a criteria and converts it
  # into a query-friendly form. Returns invalid values as is.
  def evolve(object)
    mapping.fetch(object, object)
  end

  def mapping
    @mapping ||= const_get(:MAPPING).freeze
  end

  def inverse_mapping
    @inverse_mapping ||= mapping.invert.freeze
  end
end
