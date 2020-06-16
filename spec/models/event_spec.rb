require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    # Description
    it { should validate_length_of(:description).is_at_least(10).is_at_most(120) }

    short_description = (0..8).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(short_description).for(:description) }

    long_description = (0..120).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(long_description).for(:description) }

    # Location
    it { should validate_length_of(:location).is_at_least(5).is_at_most(50) }

    short_location = (0..3).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(short_location).for(:location) }

    long_location = (0..50).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(long_location).for(:location) }

    # Date
    it { should allow_value('2020-07-25').for(:date) }
  end

  describe 'Event' do
    # User
    it { should belong_to(:creator).class_name('User') }

    # Invitation
    it { should have_many(:invitations).dependent(:destroy) }
  end
end
