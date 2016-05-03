FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "abc#{n}"}
    sequence(:email) { |n| "abc#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :group do
    name "grp1"  
    association :user  
  end

  factory :group_member do    
  	association :group
  	association :user
  end

  # factory :paid_to_user, class: User do
  #   name "abc1"
  #   email "abc1@example.com"
  #   password "foobar1"
  #   password_confirmation "foobar1"
  # end

  # factory :paid_by_user, class: User  do
  #   name "abc2"
  #   email "abc2@example.com"
  #   password "foobar2"
  #   password_confirmation "foobar2"
  # end

  factory :transaction do    
    
    association :paid_to_user, factory: :user
    #association :paid_by_user
    association :group
    amount 0
  end
end