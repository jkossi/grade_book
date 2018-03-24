# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ROLES
roles = %w(admin teacher)

# ADMIN USER
admin = {
    email: 'dynamickossi@yahoo.com',
    password: Figaro.env.admin_password,
    first_name: 'joseph',
    last_name: 'abokpoe',
    gender: 'm',
    phone: '0547558472',
    role_id: 1,
}


roles.each do |role|
  Role.find_or_create_by!(name: role)
end

User.create!(admin)