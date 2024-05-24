class Exam < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :exam_template
  belongs_to :course
  has_one :evaluation

  enum status: {
    started: 0,
    submitted: 1
  }

  validates :due_date, presence: true, inclusion: { in: Date.current.. }
  validates :quiz_data, presence: true
  validates :version, presence: true
  validates :status, presence: true

  before_validation :populate_quiz_data, on: :create

  private

  def populate_quiz_data
    self.quiz_data = exam_template.quiz_data if quiz_data.blank?
  end
end

