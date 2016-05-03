class GroupMember < ActiveRecord::Base

  belongs_to :group, counter_cache: true
  belongs_to :user

  validates :group_id, :presence => true, on: :update
  validates :user_id, :presence => true

end
