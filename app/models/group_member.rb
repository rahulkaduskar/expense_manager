class GroupMember < ActiveRecord::Base
  #attr_accessible :group_id, :user_id

  belongs_to :group, counter_cache: true
  belongs_to :user
end
