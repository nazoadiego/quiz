FactoryBot.define do
  factory :course do
    name { "History" }
    association :teacher, factory: :user, strategy: :build
  end
end
