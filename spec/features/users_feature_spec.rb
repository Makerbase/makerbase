require 'rails_helper'

context 'User not signed in' do
  it 'should see a \'sign in\' link' do
    visit '/'
    expect(page).to have_link 'Sign In'
  end

  it 'should not see a \'sign out\' link' do
    visit '/'
    expect(page).not_to have_link 'Sign Out'
  end
end
