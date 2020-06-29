require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let!(:merry) { User.create!(first_name: 'Merry', last_name: 'Brandybuck', email: 'merry@email.com', password: 'password', password_confirmation: 'password') }
  let!(:group) { Group.create!(name: 'Running', creator_id: 1, icon: 'fas fa-running') }
  let(:create_activity) { post :create, params: { activity: { name: 'Evening Run', amount: 40, calories: 120, author_id: merry.id, group_id: group.id } } }
  let(:create_bad_activity) { post :create, params: { activity: { first_name: 'Evening Run', amount: 40, calories: 120, author_id: merry.id, group_id: group.id } } }
  before { sign_in merry }
  
  context 'new activity' do
    it 'builds a new activity with the current user as the author' do
      activity = merry.activities.build
      expect(activity.author_id).to eq(merry.id)
    end
  end

  context 'create activity' do
    it 'rejects building a new activity with incorrect params' do
      expect(merry.activities.count).to eq(0)
      create_bad_activity
      expect(merry.activities.count).to eq(0)
    end

    it 'builds a new activity with the correct parameters' do
      expect(merry.activities.count).to eq(0)
      post :create, params: { activity: { name: 'Evening Run', amount: 40, calories: 120, author_id: merry.id, group_id: group.id } }
      expect(merry.activities.count).to eq(1)
    end

    it 'creates a corresponding activity entry record upon activity creation' do
      expect(ActivityEntry.all.count).to eq(0)
      create_activity
      expect(ActivityEntry.all.count).to eq(1)
    end

    it 'displays a flash message and redirects on successful activity creation' do
      create_activity
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
    end

    it 'displays a flash message and refreshes the page upon incorrect activity creation' do
      create_bad_activity
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
    end
  end

  context 'show activity' do
    it 'fetches the page and renders without errors' do
      create_activity
      get :show, params: { id: '1' }
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct name, amount(time), calories and icon' do
      create_activity
      get :show, params: { id: '1' }
      expect(assigns(:activity)).to have_attributes(
        name: 'Evening Run',
        author_id: merry.id,
        amount: 40,
        calories: 120,
        group_id: group.id
      )
    end
  end

  context 'destroy activities' do
    it 'destroys an activity given the correct parameters' do
      create_activity
      expect(merry.activities.count).to eq(1)
      post :destroy, params: { id: '1' }
      expect(merry.activities.count).to eq(0)
    end

    it 'displays a flash message and redirects upon deletion' do
      create_activity
      post :destroy, params: { id: '1' }
      expect(response).to have_http_status(:redirect)
      expect(flash).to be_present
    end
  end
end