namespace :utils do
  desc "TODO"
  task update_group_members_count: :environment do
  	Group.all.pluck(:id).each{|id| Group.reset_counters(id, :group_members)}

  end

end
