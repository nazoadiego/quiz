FactoryBot.define do
  factory :exam do
    teacher { nil }
    student { nil }
    exam_template { nil }
    course { nil }
    due_date { "2024-05-24 15:34:50" }
    quiz_data { {} }
    version { "2024-05-24 15:34:50" }
    status { 0 }
  end
end
