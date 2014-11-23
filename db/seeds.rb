require 'faker'

# Create Users
# Notes:
#   - Calling 'User.new,' instead of 'User.create,' we create
#     an instance of User that is not immediately saved to the
#     database.
#
#   - The 'skip_confirmation!' method sets the 'confirmed_at'
#     attribute to avoid triggering a confirmation email when
#     User is saved.
#
#   - The 'save!' method then saves User to the database
5.times do
  user = User.new(
    name:      Faker::Name.name,
    email:     Faker::Internet.email,
    password:  Faker::Lorem.characters(10),
    role:      'member'
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph,
    user:  users.sample
  )
end

# Create 'Admin User'
admin = User.new(
  name:      'Admin User',
  email:     'admin@kimwiki.com',
  password:  'helloworld',
  role:      'admin'
)
admin.skip_confirmation!
admin.save!

# Create 'Moderator'
moderator = User.new(
  name:      'Moderator User',
  email:     'moderator@kimwiki.com',
  password:  'helloworld',
  role:      'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create 'Member'
member = User.new(
  name:      'Member User',
  email:     'member@kimwiki.com',
  password:  'helloworld',
  role:      'member'
)
member. skip_confirmation!
member.save!

puts "Seed completed"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
