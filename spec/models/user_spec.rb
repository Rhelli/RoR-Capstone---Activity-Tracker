require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user model validations' do
    it 'approves new users when all parameters are present' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to be_valid
    end

    it 'rejects new users with no first name' do
      samwise = User.new(first_name: nil, last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with incorrectly formatted first names' do
      samwise = User.new(first_name: '$@|^^|\./|$€', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users if their first name is too long' do
      samwise = User.new(first_name: 'S' * 51, last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with no last name' do
      samwise = User.new(first_name: 'Samwise', last_name: nil, email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects users with incorrectly formatted last names' do
      samwise = User.new(first_name: 'Samwise', last_name: '&@/\/\&€€', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with too long a last name' do
      samwise = User.new(first_name: 'Samwise', last_name: 'G' * 51, email: 'samwise@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users without a valid email address' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with too long an email address' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 's' * 243 + '@hobbiton.com', password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users without any email at all' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: nil, password: 'password', password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users without a password' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: nil, password_confirmation: 'password')
      expect(samwise).to_not be_valid
    end

    it 'rejects new users without a password confirmation' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'password', password_confirmation: nil)
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with passwords which are too long' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'p' * 33, password_confirmation: 'p' * 129)
      expect(samwise).to_not be_valid
    end

    it 'rejects new users with passwords which are too short' do
      samwise = User.new(first_name: 'Samwise', last_name: 'Gamgee', email: 'samwise@hobbiton.com', password: 'p' * 6, password_confirmation: 'p' * 6)
      expect(samwise).to_not be_valid
    end
  end
end
