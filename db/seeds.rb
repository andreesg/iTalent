# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# 5.times do |i|
#   User.create!(
#     email: "teste#{i}@example.com",
#     password: "12345678",
#     password_confirmation: "12345678"
#   )
# end

puts "####################################################################################"
puts "                              Seeding Database                                      "
puts "####################################################################################"

org1 = Organization.create!(
    name: "iTGrow"
)

org2 = Organization.create!(
    name: "Critical Software"
)

User.create!(
    name: "Gonçalo Pereira",
    email: "pereira@itgrow.com",
    password: "12345678",
    password_confirmation: "12345678",
    role: "admin",
    organization_id: org1.id
)

User.create!(
    name: "Gonçalo Palaio",
    email: "palaio@itgrow.com",
    password: "12345678",
    password_confirmation: "12345678",
    role: "admin",
    organization_id: org1.id
)

User.create!(
    name: "Ana Laranjeira",
    email: "laranjeira@itgrow.com",
    password: "12345678",
    password_confirmation: "12345678",
    role: "admin",
    organization_id: org2.id
)

User.create!(
    name: "Miguel Bernardes",
    email: "bernardes@itgrow.com",
    password: "12345678",
    password_confirmation: "12345678",
    role: "admin",
    organization_id: org2.id
)

User.create!(
    name: "João Costa",
    email: "costa@itgrow.com",
    password: "12345678",
    password_confirmation: "12345678",
    role: "admin",
    organization_id: org2.id
)

# 10.times do |i|
#   Tag.create!(name: "Tag ##{i}", num_subscribers: 0)
# end

Tag.create!(name: "Informatica", num_subscribers: 0)
Tag.create!(name: "Desporto", num_subscribers: 0)

# 10.times do
#   e = Event.new(
#     title: "Evento ##{(rand*1000).to_i}",
#     description: "Lorem impsum bla "*(rand*15).ceil,
#     location: "Coimbra",
#     date_limit: Time.now + (rand*10).to_i.days,
#     date_start: Time.now + (10 + rand*10).to_i.days,
#     num_attendings: (rand*100).to_i,
#     num_invitations: (rand*100).to_i,
#   )

#   e.creator = User.order("random()").limit(1).to_a.first
#   e.tags << Tag.order("random()").limit(2)

#   e.save!
# end

e = Event.new(
    title: "Java Jug",
    description: "Java user group meeting",
    location: "Coimbra, Fctuc, Dei",
    date_limit: Time.now + 5.to_i.days,
    date_start: Time.now + 6.to_i.days,
    num_attendings: 0,
    num_invitations: 0
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

e = Event.new(
    title: "Bowling",
    description: "asdasda",
    location: "asdasda",
    date_limit: Time.now + 3.to_i.days,
    date_start: Time.now + 5.to_i.days,
    num_attendings: 0,
    num_invitations: 0
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

e = Event.new(
    title: "Acampamento de Informaticos",
    description: "asdasda",
    location: "asdasda",
    date_limit: Time.now + 7.to_i.days,
    date_start: Time.now + 10.to_i.days,
    num_attendings: 0,
    num_invitations: 0
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

e = Event.new(
    title: "Paintball",
    description: "asdasda",
    location: "asdasda",
    date_limit: Time.now + 3.to_i.days,
    date_start: Time.now + 8.to_i.days,
    num_attendings: 0,
    num_invitations: 0
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

# 15.times do
#   e = Publication.new(
#     text: "Lorem impsum "*(rand*10).ceil,
#   )

#   e.creator = User.order("random()").limit(1).to_a.first
#   e.tags << Tag.order("random()").limit(2)

#   e.save!
# end

# - 1
e = Publication.new(
    text: "Nova versao de Rails!",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "cena")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 2
e = Publication.new(
    text: "Parabens a todos! Ganhamos o prémio de melhor empresa do ano!",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "cena")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 3
e = Publication.new(
    text: "Quem é que sabe programar em RubyOnRails?",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "cena")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 4
e = Publication.new(
    text: "Publiquei um artigo científico. Vejam o link...",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "Bela merda...")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 5
e = Publication.new(
    text: "Oh pra min já sei programar...",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "Ai sim??")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 6
e = Publication.new(
    text: "Ole ole.",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "Coisito")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!

# - 6
e = Publication.new(
    text: "Hoje fui a vila e vi...",
  )

e.creator = User.order("random()").limit(1).to_a.first
e.tags << Tag.order("random()").limit(2)
e.save!

c = Comment.new(text: "Viste o que?")
c.creator = User.order("random()").limit(1).to_a.first
c.publication = e
c.save!
