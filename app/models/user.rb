class User < ApplicationRecord
  # Teacher relations
  has_many :courses

  # Students relations
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course

  # Scope to distinguish roles
  scope :teachers, -> { where(role: 'teacher') }
  scope :students, -> { where(role: 'student') }

  enum role: {
    student: 0,
    teacher: 1
  }
end
