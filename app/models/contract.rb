class Contract < ActiveRecord::Base
  attr_accessible :assigned, :client, :instructions, :open, :pending, :price, :requestedBy, :user_id
  belongs_to :user
end
