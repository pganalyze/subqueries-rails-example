class Employee < ApplicationRecord
  belongs_to :role
  has_many :performance_reviews
  has_many :employee_reviews,
           class_name: 'PerformanceReview', foreign_key: :reviewer_id
  has_many :vacations
end
