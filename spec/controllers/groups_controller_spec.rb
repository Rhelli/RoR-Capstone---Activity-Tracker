require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:gandalf) { User.create!(first_name: 'Gandalf', last_name: 'Bladorthin', email: 'gandalf@email.com', password: 'password', password_confirmation: 'password') }
  let!(:pippin) { User.create!(first_name: 'Pippin', last_name: 'Took', email: 'fool@took.com', password: 'password', password_confirmation: 'password') }
  let!(:running) { Group.create!(name: 'Running', creator_id: gandalf.id, icon: 'fas fa-burn') }
  let(:create_valid_group) { post :create, params: { group: { name: 'Jogging', creator_id: gandalf.id, icon: 'fas fa-burn' } } }
  before { sign_in gandalf }
  context 'groups new action' do
    it 'builds a new group with the current user as the creator' do
      a = gandalf.groups.build
      expect(a).to have_attributes(creator_id: gandalf.id)
    end
  end

  context 'groups create action' do
    it 'creates a membership automatically for the creator of the group' do
      expect(gandalf.memberships.count).to eq(0)
      create_valid_group
      expect(gandalf.memberships.count).to eq(1)
    end

    it 'displays flash messages and redirects the user to the new group upon creation' do
      create_valid_group
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
      expect(assigns(:group)).to be_present
    end

    it 'displays a flash message and refreshes the page if the new group cant be created' do
      post :create, params: { group: { name: 'Cheese', description: 'We refuse to exercise. Only cheese.', creator_id: '2', icon: 'fas fa-cheese' } }
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
    end
  end

  context 'groups show actions' do
    it 'fetches and displays the correct group' do
      create_valid_group
      get :show, params: { id: '1' }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:group)).to have_attributes(name: 'Running')
    end

    it 'displays the groups members' do
      create_valid_group
      Membership.create!(user_id: pippin.id, group_id: '1')
      get :show, params: { id: '1' }
      expect(response).to have_http_status(:success)
      expect(assigns(:group_members).last).to have_attributes(id: 2)
    end

    it 'displays recent group activities' do
      create_valid_group
      Membership.create!(user_id: pippin.id, group_id: 1)
      a = Activity.create!(name: 'Evening Run', amount: 12, calories: 320, author_id: pippin.id, group_id: 1)
      ActivityEntry.create!(activity_id: a.id, group_id: 1)
      get :show, params: { id: '1' }
      expect(assigns(:group_activities).count).to eq(1)
      expect(assigns(:group_activities).first).to have_attributes(name: 'Evening Run')
    end
  end

  context 'groups destroy action' do
    it 'destroy a group given the correct parameters' do
      post :destroy, params: { id: 1 }
      expect(Group.all.count).to eq(0)
    end

    it 'displays a flash message and redirects the user back to their profile' do
      get :show, params: { id: 1 }
      post :destroy, params: { id: 1 }
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
    end
  end
end
