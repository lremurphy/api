class Product < ActiveRecord::Base
  acts_as_paranoid

  store_accessor :options
end
