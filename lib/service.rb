class Service

  attr_reader :service_type_id,
              :name,
              :description,
              :price,
              :price_details

  def initialize(attributes)
    @service_type_id = attributes[:service_type_id]
    @name = attributes[:name]
    @description = attributes[:description]
    @price = attributes[:price]
    @price_details = attributes[:price_details]
  end

  def to_h
    {
    :service_type_id => service_type_id,
    :name => name,
    :description => description,
    :price => price,
    :price_details => price_details
    }
  end

end
