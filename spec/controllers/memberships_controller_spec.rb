require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  let!(:gandalf) { User.create!(first_name: 'Gandalf', last_name: 'Bladorthin', email: 'gandalf@email.com', password: 'password', password_confirmation: 'password') }
  let!(:frodo) { User.create!(first_name: 'Frodo', last_name: 'Baggins', email: 'frodo@hobbiton.com', password: 'password', password_confirmation: 'password') }
  let!(:group1) { Group.create!(name: 'Running', description: nil, creator_id: '1', icon: 'fas fa-burn') }
  let(:create_valid_membership) { post :create, params: { user_id: frodo.id, group_id: group1.id } }
  let(:create_invalid_membership) { post :create, params: { method: :delete } }

  before { sign_in frodo }
  context 'memberships new action' do
    it 'builds a new membership with the current user' do
      a = frodo.memberships.build
      expect(a.user_id).to eq(frodo.id)
    end
  end

  context 'memberships create action' do
    it 'creates a new membership when given the correct parameters' do
      create_valid_membership
      expect(Membership.count).to eq(1)
    end

    it 'rejects a new membership with unpermitted parameters' do
      create_invalid_membership
      expect(Membership.count).to eq(0)
    end

    it 'displays a flash message if the membership is saved successfully' do
      create_valid_membership
      expect(flash).to be_present
    end

    it 'displays a flash message if the membership is not saved successfully' do
      create_invalid_membership
      expect(flash).to be_present
    end
  end

  context 'memberships show action' do
    it 'displays the current users active memberships' do
      create_valid_membership
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(assigns(:my_memberships).first).to have_attributes(group_id: 1)
    end

    it 'displays suggested groups to the user that they are not members of' do
      create_valid_membership
      Group.create!(name: 'Swimming', creator_id: 1, icon: 'fas fa-burn')
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(assigns(:non_memberships).first).to_not have_attributes(group_id: '1')
      expect(assigns(:non_memberships).count).to eq(Group.all.count - 1)
    end
  end
end
