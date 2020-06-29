require 'rails_helper'

RSpec.describe ActivityEntriesController, type: :controller do
  let!(:pippin) { User.create!(first_name: 'Pippin', last_name: 'Took', email: 'fool@took.com', password: 'password', password_confirmation: 'password') }
  let!(:running) { Group.create!(name: 'Running', creator_id: '1', icon: 'fas fa-running') }
  let(:evening_run1) { Activity.create!(name: 'Evening Run', amount: 40, calories: 400000, author_id: pippin.id, group_id: running.id) }
  before { sign_in pippin }
  context 'activity entry index action' do
    it 'renders the correct page and shows all the users activities' do
      get :index
      expect(response).to render_template(:index)
      evening_run1
      ActivityEntry.create!(activity_id: '1', group_id: '1')
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:my_activities).count).to eq(1)
      expect(assigns(:my_activities).first).to have_attributes(name: 'Evening Run')
    end

    it 'displays the users activities in order of their creation date' do
      evening_run1
      ActivityEntry.create!(activity_id: evening_run1.id, group_id: '1')
      past_date = Date.today - 300
      old_activity = Activity.create!(name: 'Old Activity', amount: 50, calories: 400, created_at: past_date, updated_at: past_date, author_id: '1')
      ActivityEntry.create!(activity_id: old_activity.id, group_id: '1')
      get :index
      expect(assigns(:my_activities).count).to eq(2)
      expect(assigns(:my_activities).first).to have_attributes(id: evening_run1.id)
      expect(assigns(:my_activities).last).to have_attributes(id: old_activity.id)
    end
  end


end