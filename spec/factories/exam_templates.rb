FactoryBot.define do
  factory :exam_template do
    title { "History Exam" }
    quiz_data { {} }
    version { Date.current }
  end
end
