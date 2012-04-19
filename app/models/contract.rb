class Contract < ActiveRecord::Base
  attr_accessible :assigned, :client, :instructions, :open, :pending, :price, :requestedBy, :user_id
  belongs_to :user
  validates :client, :price,:requestedBy, :presence => true
  validates :price, :numericality => true 
end
