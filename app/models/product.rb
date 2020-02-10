class Product # PORO -> Plain Old Ruby Object
  attr_accessor :id, :key
  def initialize(id, key)
    @id = id
    @key = key
  end

  def self.all
    response = Faraday.get('http://localhost:4000/api/v1/product_types')
    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)

    json.map do |item|
      Product.new(item[:id], item[:product_key])
    end
  end
end
