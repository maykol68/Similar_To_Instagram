require 'faker'

10.times do |_i|
    User.create( username: Faker::Internet.unique.username(specifier: 5..10),
                 name: Faker::Name.name,
                 email: Faker::Internet.unique.email,
                 password: Faker::Internet.password(min_length: 8),
                 password_confirmation: Faker::Internet.password(min_length: 8))
end

User.reindex
