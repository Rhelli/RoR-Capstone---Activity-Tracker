require 'rails_helper'

RSpec.describe Activity, type: :model do
  let!(:example_user) { User.create!(first_name: 'Frodo', last_name: 'Baggins', email: 'sharetheload@email.com', password: 'password', password_confirmation: 'password') }
  context 'activity model validations' do
    it 'accepts a new activity entry with correct parameters' do
      run = Activity.new(name: 'Evening Run', amount: 40, calories: 300, author_id: example_user.id)
      expect(run).to be_valid
    end

    it 'rejects a new activity without a name' do
      run = Activity.new(name: nil, amount: 40, calories: 300)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity with too long a name' do
      run = Activity.new(name: 'a' * 51, amount: 40, calories: 300)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity without an amount' do
      run = Activity.new(name: 'Evening Run', amount: nil, calories: 300)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity with an incorrect amount format' do
      run = Activity.new(name: 'Evening Run', amount: 'forty', calories: 300)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity with a negative amount' do
      run = Activity.new(name: 'Evening Run', amount: -40, calories: 300)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity without a calorie count' do
      run = Activity.new(name: 'Evening Run', amount: 40, calories: nil)
      expect(run).to_not be_valid
    end

    it 'rejects a new activity with an incorrect format' do
      run = Activity.new(name: 'Evening Run', amount: 40, calories: 'this is sparta')
      expect(run).to_not be_valid
    end

    it 'rejects a new activity with a negative calorie count' do
      run = Activity.new(name: 'Evening Run', amount: 40, calories: -300)
      expect(run).to_not be_valid
    end
  end

  context 'activity model associations' do
    it 'has only one activity entry' do
      x = Activity.reflect_on_association(:activity_entry)
      expect(x.macro).to eq(:has_one)
    end

    it 'has one group' do
      x = Activity.reflect_on_association(:group)
      expect(x.macro).to eq(:has_one)
    end

    it 'belongs to an author' do
      x = Activity.reflect_on_association(:author)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
