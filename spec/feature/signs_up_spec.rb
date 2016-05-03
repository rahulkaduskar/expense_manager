require 'rails_helper'
feature 'User signs up' do
  before :each do
    @user = create(:user)
    sign_up_with @user.email, 'foobar'
  end


  scenario 'with valid email and password' do    
    expect(page).to have_content('Create groups')
  end

  scenario 'with invalid email' do
    logout(:user)
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Invalid email or password')
  end

  scenario 'with blank password' do
    logout(:user)
    sign_up_with @user.email, ''

    expect(page).to have_content('Invalid email or password')
  end

  
end