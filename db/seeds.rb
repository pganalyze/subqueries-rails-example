first_names = %w[Bob Alice Joe Amanda Ben]
last_names = %w[Williams Hawkins Serna Florez Halliday]

Employee.delete_all
Vacation.delete_all
Role.delete_all
PerformanceReview.delete_all

Employee.transaction do
  roles =
    [
      'Finance',
      'Engineering',
      'Customer Success',
      'Sales',
      'Marketing'
    ].map { |name| Role.create(name: name) }

  employees =
    (1..1_000).map do |num|
      p "Employee: #{num}"
      Employee.create!(
        name: "#{first_names.sample} #{last_names.sample}",
        role: roles.sample,
        salary: rand(50_000..150_000)
      )
    end

  (1..1_000).each do |num|
    p "Vacation: #{num}"
    starts_on = rand(0..365).days.ago.to_date
    ends_on = starts_on + rand(1..20).days

    Vacation.create!(
      employee: employees.sample,
      starts_on: starts_on,
      ends_on: ends_on,
      days: (ends_on - starts_on).to_i
    )
  end

  (1..10_000).map do |num|
    p "Performance Review: #{num}"
    PerformanceReview.create!(
      employee: employees.sample,
      reviewer: employees.sample,
      score: rand(1..100)
    )
  end
end
