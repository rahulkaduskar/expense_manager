class AddGroupsMembersCount < ActiveRecord::Migration
  def change
  	add_column :groups, :group_members_count, :integer  
  end
end
