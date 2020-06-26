require 'rails_helper'

RSpec.describe ActivityEntriesController, type: :controller do
  let!(:pippin) { User.create!(first_name: 'Pippin', last_name: 'Took', email: 'fool@took.com', password: 'password', password_confirmation: 'password') }
  let!(:running) { Group.create!(name: 'Running', creator_id: '1', icon: 'fas fa-running') }
  before { sign_in pippin }
  context 'activity entry show action' do
    it 'renders the correct page and shows all the users activities' do
      Activity.create!(name: 'Running', amount: 40, calories: 400000, author_id: pippin.id, group_id: running.id)
      ActivityEntry.create!(user_id: '1', group_id: '1')
      get :show
      expect(response).to have_http_response(:success)
      expect(response).to render_template(:show)
      expect(assigns(:my_activities).count).to eq(1)
      expect(assigns(:my_activities).count).to have_attributes(user_id: '1', group_d: '1')
    end
  end
end