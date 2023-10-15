class Base < ApplicationRecord
  validates :base_name, presence: true
  validates :base_number, presence: true
  validates :information, presence: true
end
