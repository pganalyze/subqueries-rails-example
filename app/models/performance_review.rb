class PerformanceReview < ApplicationRecord
  belongs_to :employee
  belongs_to :reviewer, class_name: 'Employee'
end
