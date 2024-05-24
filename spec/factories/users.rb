FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john.doe@example.com" }
    role { :student }
  end

  trait :teacher do
    role { :teacher }
  end

  trait :student do
    role { :student }
  end
end
