class Group < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }

  has_many :group_members

  has_many :transactions

  before_create :add_group_member
  
  accepts_nested_attributes_for :group_members


  def add_group_member
  	group_member = GroupMember.new
    group_member.group_id = self.id
    group_member.user_id = self.user_id
    binding.pry
    self.group_members << group_member
  end

end
