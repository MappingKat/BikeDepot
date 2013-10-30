class ServiceType

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def to_h
    {
    :name => name
    }
  end

  def services
    Services.find_all_by_service_type_id(id)
  end

end
