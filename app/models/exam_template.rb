class ExamTemplate < ApplicationRecord
  has_many :exams

  validates :title, presence: true
  validates :quiz_data, presence: true
end