module Spree
  # Navision Item
  class NavisionItem < ApplicationRecord
    include Persistence
    validates :key, presence: true, uniqueness: true
    validates :no, presence: true
    validates :rec_id, presence: true
  end
end
