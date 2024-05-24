FactoryBot.define do
  factory :evaluation do
    exam { nil }
    total_score { 1 }
    quiz_data { "" }
    status { 1 }
  end
end
