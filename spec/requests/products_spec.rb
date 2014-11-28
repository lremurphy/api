require 'rails_helper'

RSpec.describe 'Products API' do
  let(:default_params) { { format: :json } }

  describe 'GET index' do
    before(:each) do
      create :product
      create :product
      @products = Product.all
    end

    it 'returns a collection of all of the products', :show_in_doc do
      get '/products'
      expect(response.body).to eq(@products.to_json)
    end

    it 'returns a collection of all of the products w/ chargebacks', :show_in_doc do
      get '/products', include: %w(chargebacks)
      expect(json[0]['chargebacks']).to_not eq(nil)
    end
  end

  describe 'GET show' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'returns an product' do
      get "/products/#{@product.id}"
      expect(response.body).to eq(@product.to_json)
    end

    it 'returns an product w/ chargebacks', :show_in_doc do
      get "/products/#{@product.id}", include: %w(chargebacks)
      expect(json['chargebacks']).to_not eq(nil)
    end

    it 'returns an error when the product does not exist' do
      get "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'PUT update' do
    before(:each) do
      create :product
      @product = Product.first
    end

    it 'updates a product', :show_in_doc do
      put "/products/#{@product.id}", product: { options: ['test'] }
      expect(JSON(response.body)['options']).to eq(['test'])
    end

    it 'returns an error if the product parameter is missing' do
      put "/products/#{@product.id}"
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: product')
    end

    it 'returns an error when the product does not exist' do
      put "/products/#{@product.id + 999}", product: { options: ['test']  }
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end

  describe 'POST create' do
    it 'creates an product', :show_in_doc do
      post '/products/', product: { options: ['test'] }
      expect(response.body).to eq(Product.first.to_json)
    end

    it 'returns an error if the product is missing' do
      post '/products/'
      expect(response.status).to eq(422)
      expect(JSON(response.body)).to eq('error' => 'param is missing or the value is empty: product')
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @product = create :product
    end

    it 'removes the product', :show_in_doc do
      delete "/products/#{@product.id}"
      expect(response.status).to eq(200)
    end

    it 'returns an error when the product does not exist' do
      delete "/products/#{@product.id + 999}"
      expect(response.status).to eq(404)
      expect(JSON(response.body)).to eq('error' => 'Not found.')
    end
  end
end