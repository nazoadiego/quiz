class Evaluation < ApplicationRecord
  belongs_to :exam

  enum status: {
    started: 0,
    submitted: 1
  }

  validates :total_score, 
  presence: true, 
  numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 100 
  }

  validates :quiz_data, presence: true
  validates :status, presence: true

  before_validation :populate_quiz_data, on: :create

  private

  def populate_quiz_data
    self.quiz_data = exam_template.quiz_data if quiz_data.blank?
  end
end
