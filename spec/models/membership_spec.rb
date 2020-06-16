require 'rails_helper'

RSpec.describe Membership, type: :model do
  context 'membership model associations' do
    it 'belongs to a user' do
      x = Membership.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a group' do
      x = Membership.reflect_on_association(:group)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
