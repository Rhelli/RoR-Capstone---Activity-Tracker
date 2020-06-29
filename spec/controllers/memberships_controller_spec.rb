require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  let!(:gandalf) { User.create!(first_name: 'Gandalf', last_name: 'Bladorthin', email: 'gandalf@email.com', password: 'password', password_confirmation: 'password') }
  let!(:frodo) { User.create!(first_name: 'Frodo', last_name: 'Baggins', email: 'frodo@hobbiton.com', password: 'password', password_confirmation: 'password') }
  let!(:group1) { Group.create!(name: 'Running', description: nil, creator_id: '1', icon: 'fas fa-burn') }
  
  before { sign_in frodo }
  context 'memberships new action' do
    it 'builds a new membership with the current user' do
      a = frodo.memberships.build
      expect(a.user_id).to eq(frodo.id)
    end
  end

  context 'memberships create action' do
    it 'creates a new membership when given the correct parameters' do
      post :create, params: { membership: { user_id: frodo.id, group_id: group1.id } }
      expect(Membership.count).to eq(1)
    end
  end
end