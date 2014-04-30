# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
5.times do |i|
  User.create!(
    email: "teste#{i}@example.com",
    password: "12345678",
    password_confirmation: "12345678"
  )
end

10.times do |i|
  Tag.create!(name: "Tag ##{i}", num_subscribers: 0)
end

10.times do
  e = Event.new(
    title: "Evento ##{(rand*1000).to_i}",
    description: "Lorem impsum bla "*(rand*15).ceil,
    location: "Coimbra",
    date_limit: Time.now + (rand*10).to_i.days,
    date_start: Time.now + (10 + rand*10).to_i.days,
    num_attendings: (rand*100).to_i,
    num_invitations: (rand*100).to_i,
  )

  e.creator = User.order("random()").limit(1).to_a.first
  e.tags << Tag.order("random()").limit(2)

  e.save!
end

15.times do
  e = Publication.new(
    text: "Lorem impsum "*(rand*10).ceil,
  )

  e.creator = User.order("random()").limit(1).to_a.first
  e.tags << Tag.order("random()").limit(2)

  e.save!
end
