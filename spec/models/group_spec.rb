require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'group model validations' do
    it 'approves a new group when provided the correct parameters' do
      running = Group.new(name: 'Running', description: 'The process of putting one leg in front of the other')
      expect(running).to be_valid
    end

    it 'rejects a new group without a name' do
      running = Group.new(name: nil, description: 'The process of putting one leg in front of the other')
      expect(running).to_not be_valid
    end

    it 'rejects a new group if the name is too short' do
      running = Group.new(name: 'aa', description: 'The process of putting one leg in front of the other')
      expect(running).to_not be_valid
    end

    it 'rejects a new group if the name is too long' do
      running = Group.new(name: 'a' * 51, description: 'The process of putting one leg in front of the other')
      expect(running).to_not be_valid
    end

    it 'rejects a new group with an incorrectly formatted name' do
      wut = Group.new(name: '$^£$(}}{s}', description: 'The process of putting one leg in front of the other')
      expect(wut).to_not be_valid
    end

    it 'rejects a group with an already used name, regardless of case' do
      Group.create!(name: 'Running', description: 'The process of putting one leg in front of the other')
      running_copy = Group.new(name: 'running', description: 'The process of putting one leg in front of the other')
      expect(running_copy).to_not be_valid
    end

    it 'rejects a group with too long a description' do
      running = Group.new(name: 'Running', description: 'a' * 81)
      expect(running).to_not be_valid
    end

    it 'allows a group without a description' do
      running = Group.new(name: 'Running', description: nil)
      expect(running).to be_valid
    end
  end
end
