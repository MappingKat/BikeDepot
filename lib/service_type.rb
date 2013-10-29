class ServiceType

  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def to_h
    {
    :name => name
    }
  end

end
