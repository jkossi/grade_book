ROLES = %w(admin teacher)

DEPARTMENTS = %w(pre-schol upper-primary lower-primary J.H.S)

ADMIN_LINKS = [
    'Add Staff',
    'Add Departments',
    'Add Classes',
    'Add Student',
    'Add Academic Sessions',
    'Add Roles'
]

TERM = (1..3).map do |term|
  [term, term.to_s]
end

YEAR = (2018..2020).map do |year|
  [year, year.to_s]
end

GENDER = %w(m f).map do |sex|
  sex_full = sex === 'm' ? 'Male' : 'Female'
  [sex_full, sex]
end



