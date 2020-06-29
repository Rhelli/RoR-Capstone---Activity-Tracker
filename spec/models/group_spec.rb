require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:example_user) { User.create!(first_name: 'Gimli', last_name: 'Son of Gloin', email: 'aMine@email.com', password: 'password', password_confirmation: 'password') }
  context 'group model validations' do
    it 'approves a new group when provided the correct parameters' do
      running = Group.new(name: 'Running', description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(running).to be_valid
    end

    it 'rejects a new group without a name' do
      running = Group.new(name: nil, description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(running).to_not be_valid
    end

    it 'rejects a new group if the name is too short' do
      running = Group.new(name: 'aa', description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(running).to_not be_valid
    end

    it 'rejects a new group if the name is too long' do
      running = Group.new(name: 'a' * 51, description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(running).to_not be_valid
    end

    it 'rejects a new group with an incorrectly formatted name' do
      wut = Group.new(name: '$^£$(}}{s}', description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(wut).to_not be_valid
    end

    it 'rejects a new group without a creator_id' do
      tossing = Group.new(name: 'Tossing a Dwarf', description: 'Nobody tosses a dwarf')
      expect(tossing).to_not be_valid
    end

    it 'allows a new group with a name containing numbers' do
      oneup = Group.new(name: '1upFitness', description: "When you've just got to practice stomping goombas", creator_id: example_user.id)
      expect(oneup).to be_valid
    end

    it 'rejects a group with an already used name, regardless of case' do
      Group.create!(name: 'Running', description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      running_copy = Group.new(name: 'running', description: 'The process of putting one leg in front of the other', creator_id: example_user.id)
      expect(running_copy).to_not be_valid
    end

    it 'rejects a group with too long a description' do
      running = Group.new(name: 'Running', description: 'a' * 81, creator_id: example_user.id)
      expect(running).to_not be_valid
    end

    it 'allows a group without a description' do
      running = Group.new(name: 'Running', description: nil, creator_id: example_user.id)
      expect(running).to be_valid
    end
  end

  context 'group model associations' do
    it 'belongs to a creator' do
      x = Group.reflect_on_association(:creator)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'has many memberships' do
      x = Group.reflect_on_association(:memberships)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many users through memberships' do
      x = Group.reflect_on_association(:users)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many activity entries' do
      x = Group.reflect_on_association(:activity_entries)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many activities through activity_entries' do
      x = Group.reflect_on_association(:activities)
      expect(x.macro).to eq(:has_many)
    end
  end
end
