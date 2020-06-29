require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user1) { User.create!(first_name: 'Example', last_name: 'User', email: 'example@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(first_name: 'Another Example', last_name: 'User', email: 'anotherexample@email.com', password: 'password', password_confirmation: 'password') }
  let!(:group1) { Group.create!(name: 'Running', creator_id: 1, icon: 'fas fa-burn') }
  let!(:group2) { Group.create!(name: 'Jogging', creator_id: 1, icon: 'fas fa-burn') }
  let!(:group3) { Group.create!(name: 'Rowing', creator_id: 2, icon: 'fas fa-burn') }
  let!(:membership1) { Membership.create!(user_id: 1, group_id: 1) }
  let!(:membership2) { Membership.create!(user_id: 1, group_id: 2) }
  let!(:new_activity) { Activity.create!(name: 'Evening Run', amount: 40, calories: 300, author_id: 1, group_id: 1) }
  let!(:newish_activity) { Activity.create!(name: 'Evening Jog', amount: 20, calories: 150, author_id: 1, group_id: 2, created_at: Date.today - 2) }
  let!(:old_activity) { Activity.create!(name: 'Old Jog', amount: 20, calories: 2000, author_id: 1, group_id: 2, created_at: Date.today - 50) }
  let(:old_activity2) { Activity.create!(name: 'Evening Run 2', amount: 40, calories: 300, author_id: 1, group_id: 1, created_at: Date.today - 4) }
  let(:old_activity3) { Activity.create!(name: 'Evening Run 3', amount: 40, calories: 300, author_id: 1, group_id: 1, created_at: Date.today - 6) }
  let(:old_activity4) { Activity.create!(name: 'Evening Run 4', amount: 40, calories: 300, author_id: 1, group_id: 1, created_at: Date.today - 32) }
  before { sign_in user1 }
  context 'user show action' do
    it 'shows all of the users membership groups' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(assigns(:my_groups).count).to eq(2)
      expect(assigns(:my_groups).first).to have_attributes(name: 'Running')
      expect(assigns(:my_groups).last).to have_attributes(name: 'Jogging')
    end

    it 'displays an ordered list of the all of the users activities' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(assigns(:all_activities).count).to eq(3)
      expect(assigns(:all_activities).first).to have_attributes(name: 'Evening Run')
      expect(assigns(:all_activities).last).to have_attributes(name: 'Old Jog')
    end

    it 'displays the users most recent activites within the last 28 days' do
      old_activity2
      old_activity3
      old_activity4
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
      expect(assigns(:recent_activities_all).count).to eq(4)
      expect(assigns(:recent_activities_all).last).to have_attributes(name: 'Evening Run 3')
    end
  end
end
