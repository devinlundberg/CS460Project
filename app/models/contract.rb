class Contract < ActiveRecord::Base
  attr_accessible :humanizer_answer,:humanizer_question_id,:assigned, :client, :instructions, :open, :pending, :price, :requestedBy, :user_id
  belongs_to :user
  validates :client, :price,:requestedBy, :presence => true
  validates :price, :numericality => true 
  include Humanizer
  require_human_on :create
end
