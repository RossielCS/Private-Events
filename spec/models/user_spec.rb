require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(username: 'Paul', email: 'paul@mail.com') }

  describe 'Validations' do
    # Username
    it { should validate_length_of(:username).is_at_least(4).is_at_most(20) }

    it { should_not allow_value('').for(:username) }

    short_name = (0..2).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(short_name).for(:username) }

    long_name = (0..20).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(long_name).for(:username) }

    it { should validate_uniqueness_of(:username).case_insensitive }

    # Email
    it { should validate_length_of(:email).is_at_most(50) }

    email = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(email).for(:email) }

    it { should allow_value('email@mail.com').for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'User' do
    # Events
    it { should have_many(:events).with_foreign_key('creator_id') }

    # Invitations
    it { should have_many(:invitations).with_foreign_key('attendee_id') }
    it { should have_many(:attended_events).through(:invitations) }
  end
end
