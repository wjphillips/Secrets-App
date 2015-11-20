require 'rails_helper'
RSpec.describe 'editing user' do
  it 'displays prepopulated form' do
    user = create_user
    log_in user
    click_link 'Edit Profile'
    expect(page).to have_field('email')
    expect(page).to have_field('name')
  end
end