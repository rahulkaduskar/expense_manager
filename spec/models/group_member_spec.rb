require 'rails_helper'
require 'spec_helper'

RSpec.describe GroupMember, type: :model do

  it "should be valid with a user id" do
  	@member = create(:group_member)
    expect(@member).to be_valid 
  end

  it "should not be valid without user_id" do
    group = create(:group)
    member = GroupMember.new({group_id: group.id})
    expect(member).not_to be_valid 
    expect(member.errors[:user_id]).to include("can't be blank")
  end

end
