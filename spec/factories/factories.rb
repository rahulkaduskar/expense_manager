FactoryGirl.define do
  factory :user do
    name "abc"
    email "abc@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end