# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  address    :string
#  name       :string
#  status     :integer          default("normal")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Store < ApplicationRecord

  enum status: {normal: 1, payment_pending: 2, disabled: 3}, _prefix: true

  has_and_belongs_to_many :cars
  validates :name, presence: true
end
