# Clear existing data
Guest.destroy_all
Event.destroy_all
User.destroy_all

# Create users
puts "Start Seeding Users"
alice = User.create!(
  first_name: "Alice",
  last_name: "Smith",
  email: "alice@example.com",
  password: "password123"
)

bob = User.create!(
  first_name: "Bob",
  last_name: "Johnson",
  email: "bob@example.com",
  password: "password123"
)

charlie = User.create!(
  first_name: "Charlie",
  last_name: "Brown",
  email: "charlie@example.com",
  password: "password123"
)

dana = User.create!(
  first_name: "Dana",
  last_name: "Davis",
  email: "dana@example.com",
  password: "password123"
)

puts "Seeded Users Successfully!"

# Create events
puts "Start Seeding Events"
event1 = Event.create!(
  title: "Alice's Birthday Party",
  start_date: Time.now + 1.day,
  end_date: Time.now + 1.day + 3.hours,
  start_time: Time.now + 1.day + 2.hours,
  end_time: Time.now + 1.day + 5.hours,
  location: "Alice's House",
  user_id: alice.id,
  description: "A fun birthday party!"
)

event2 = Event.create!(
  title: "Bob's Networking Event",
  start_date: Time.now + 2.days,
  end_date: Time.now + 2.days + 3.hours,
  start_time: Time.now + 2.days + 1.hours,
  end_time: Time.now + 2.days + 4.hours,
  location: "Bob's Office",
  user_id: bob.id,
  description: "A networking event for professionals."
)

puts "Seeded Events Successfully!"

# Add guests to events
puts "Start Seeding Guests"

# Add guests to event1 (Alice's Birthday Party)
Guest.create!(
  user: alice, # Event creator as admin
  event: event1,
  role: "admin",
  rsvp_status: "accepted",
  party_size: 1
)
Guest.create!(
  user: charlie,
  event: event1,
  role: "guest",
  rsvp_status: "pending",
  party_size: 1
)
Guest.create!(
  user: dana,
  event: event1,
  role: "guest",
  rsvp_status: "accepted",
  party_size: 2
)

# Add guests to event2 (Bob's Networking Event)
Guest.create!(
  user: bob, # Event creator as admin
  event: event2,
  role: "admin",
  rsvp_status: "accepted",
  party_size: 1
)
Guest.create!(
  user: charlie,
  event: event2,
  role: "guest",
  rsvp_status: "accepted",
  party_size: 1
)
Guest.create!(
  user: alice,
  event: event2,
  role: "guest",
  rsvp_status: "declined",
  party_size: 1
)

puts "Seeded Guests Successfully!"
puts "Seeding Completed!"
