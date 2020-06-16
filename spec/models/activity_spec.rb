require 'rails_helper'

RSpec.describe Activity, type: :model do
  context 'activity model validations' do
    it 'accepts a new activity entry with correct parameters' do
      run = Activity.new(name: 'Evening Run', amount: 40, calories: 300)
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
end
