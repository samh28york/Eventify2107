# == Schema Information
#
# Table name: organizers
#
#  id              :integer          not null, primary key
#  email           :string           default(""), not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class OrganizerTest < ActiveSupport::TestCase
  # Test presence of required attributes
  test "should not save organizer without email" do
    organizer = Organizer.new
    organizer.first_name = "John"
    organizer.last_name = "Doe"
    organizer.password = "password123"
    organizer.password_confirmation = "password123"
    assert_not organizer.save, "Saved the organizer without an email"
  end

  test "should not save organizer without password" do
    organizer = Organizer.new
    organizer.email = "johndoe@example.com"
    organizer.first_name = "John"
    organizer.last_name = "Doe"
    organizer.password_confirmation = "password123"
    assert_not organizer.save, "Saved the organizer without a password"
  end

  test "should not save organizer with short password" do
    organizer = Organizer.new
    organizer.email = "johndoe@example.com"
    organizer.first_name = "John"
    organizer.last_name = "Doe"
    organizer.password = "short"
    organizer.password_confirmation = "short"
    assert_not organizer.save, "Saved the organizer with a short password"
  end

  test "should save organizer with valid attributes" do
    organizer = Organizer.new
    organizer.email = "johndoe@example.com"
    organizer.first_name = "John"
    organizer.last_name = "Doe"
    organizer.password = "password123"
    organizer.password_confirmation = "password123"
    assert organizer.save, "Failed to save the organizer with valid attributes"
  end

  test "should not save organizer with duplicate email" do
    organizer1 = Organizer.create(
      email: "johndoe@example.com",
      first_name: "John",
      last_name: "Doe",
      password: "password123",
      password_confirmation: "password123"
    )

    organizer2 = Organizer.new
    organizer2.email = "johndoe@example.com"
    organizer2.first_name = "Jane"
    organizer2.last_name = "Smith"
    organizer2.password = "password456"
    organizer2.password_confirmation = "password456"

    assert_not organizer2.save, "Saved the organizer with a duplicate email"
  end

  test "organizer should have many events" do
    organizer = Organizer.create(
      email: "johndoe@example.com",
      first_name: "John",
      last_name: "Doe",
      password: "password123",
      password_confirmation: "password123"
    )

    event = Event.create(
      title: "Event 1",
      date: Time.now,
      location: "Somewhere",
      organizer_id: organizer.id
    )

    assert_includes organizer.events, event, "Organizer does not have the event"
  end
end
