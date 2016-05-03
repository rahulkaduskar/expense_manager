require 'rails_helper'
feature 'Group create ' do
  before :each do
    @user = create(:user)
    sign_up_with @user.email, 'foobar'
  end

  scenario 'with valid name' do
    
    visit new_group_path
    fill_in 'group_name', with: "new_grp1"
    click_button 'Create'
    expect(page).to have_content('Create')
  end

  scenario 'with blank name' do   
    visit new_group_path
    fill_in 'group_name', with: ''
    click_button 'Create'
    expect(page).to have_content("Name can't be blank")
  end

end