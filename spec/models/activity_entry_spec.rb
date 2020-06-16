require 'rails_helper'

RSpec.describe ActivityEntry, type: :model do
  context 'activity entry model associations' do
    it 'belongs to an activity' do
      x = ActivityEntry.reflect_on_association(:activity)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a group' do
      x = ActivityEntry.reflect_on_association(:group)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
