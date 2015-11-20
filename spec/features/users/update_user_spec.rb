require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    user = create_user
    log_in user
    expect(page).to have_text('kobe')
    click_link 'Edit Profile'
    fill_in 'name', with: 'drake'
    fill_in 'email', with: 'drake@aol.com'
    click_button 'Update'
    expect(page).not_to have_text('kobe')
    expect(page).to have_text('drake')
  end
end