require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  describe 'Invitation' do
    # User
    it { should belong_to(:user) }

    # Event
    it { should belong_to(:event) }
  end
end