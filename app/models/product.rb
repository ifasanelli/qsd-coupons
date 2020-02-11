class Product
  attr_accessor :id, :key
  def initialize(id, key)
    @id = id
    @key = key
  end

  def self.api_version
    'v1'
  end

  def self.endpoint
    Rails.configuration.qsd_apis[:product_url]
  end

  def self.product_url
    "#{endpoint}/api/#{api_version}"
  end

  def self.all
    request_url = "#{product_url}/product_types"
    response = Faraday.get(request_url)
    return [] if response.status == 500

    json = JSON.parse(response.body, symbolize_names: true)

    json.map do |item|
      Product.new(item[:id], item[:product_key])
    end
  end
end
