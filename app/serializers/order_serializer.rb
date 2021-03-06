# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  staff_id      :integer          not null
#  project_id    :integer          not null
#  product_id    :integer          not null
#  service_id    :integer          not null
#  setup_price   :decimal(10, 4)
#  hourly_price  :decimal(10, 4)
#  monthly_price :decimal(10, 4)
#  status        :integer          default(0)
#  status_msg    :string
#
# Indexes
#
#  index_orders_on_product_id  (product_id)
#  index_orders_on_project_id  (project_id)
#  index_orders_on_service_id  (service_id)
#  index_orders_on_staff_id    (staff_id)
#

class OrderSerializer < ApplicationSerializer
  attributes :project_id, :product_id, :service_id, :setup_price, :hourly_price, :monthly_price, :monthly_cost
  attributes :created_at, :updated_at, :status, :status_msg, :id

  has_one :staff
  has_one :product
  has_one :project
  has_one :service
  has_many :answers
end
