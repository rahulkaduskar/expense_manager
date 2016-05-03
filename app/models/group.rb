class Group < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }

  has_many :group_members

  has_many :transactions

  belongs_to :user

  before_validation :add_creator_as_member, :if => Proc.new {|obj| obj.new_record?}
  
  accepts_nested_attributes_for :group_members, :reject_if => :all_blank


  def add_creator_as_member
  	group_member = GroupMember.new
    group_member.group_id = self.id
    group_member.user_id = self.user_id
    self.group_members << group_member
  end

end
