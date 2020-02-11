require 'rails_helper'

describe Product do
  it 'should get all products via API' do
    url = 'http://localhost:3000/api/v1/product_types'
    json = File.read(Rails.root.join('spec/support/jsons/product_index.json'))
    response = double('faraday_response', body: json, status: 200)

    allow(Faraday).to receive(:get).with(url).and_return(response)
    allow_any_instance_of(Faraday)

    result = Product.all

    expect(result.length).to eq 3
    expect(result[0].key).to eq 'HOSP'
    expect(result[1].key).to eq 'CLOUD'
    expect(result[2].key).to eq 'EMKT'
  end

  it 'should return an empty array if API return error' do
    url = 'http://localhost:3000/api/v1/product_types'
    response = double('faraday_response', status: 500)

    allow(Faraday).to receive(:get).with(url).and_return(response)

    result = Product.all

    expect(result.length).to eq 0
  end
end
