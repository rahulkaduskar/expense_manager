require 'rails_helper'
require 'spec_helper'

RSpec.describe Group, type: :model do
   before :each do
    @group = create(:group)
  end

  it "should be valid with a name" do
    expect(@group).to be_valid 
  end

  it "should not be valid without a name" do
    @group.name = nil
    expect(@group).not_to be_valid 
    expect(@group.errors[:name]).to include("can't be blank")
  end

end
