require 'rails_helper'

RSpec.describe 'Authentications', type: :feature do
  before :each do
    User.create(username: 'Alex', email: 'alex@mail.com')
  end

  it 'signs up' do
    visit signup_path
    fill_in 'user[username]', with: 'TestUser'
    fill_in 'user[email]', with: 'testuser@mail.com'
    click_button 'Sign Up'
    expect(page).to have_content('User successfully created.')
    expect(page).to have_content('Hi TestUser')
    expect(page).to have_content('Invitations')
    expect(page).to have_content('Upcoming')
    expect(page).to have_content('Previous')
  end

  it 'logs in' do
    visit login_path
    fill_in 'session[email]', with: 'alex@mail.com'
    click_button 'Log In'
    expect(page).to have_content('Hi Alex')
    expect(page).to have_content('Invitations')
    expect(page).to have_content('Upcoming')
    expect(page).to have_content('Previous')
  end

  it 'logs out' do
    visit login_path
    fill_in 'session[email]', with: 'alex@mail.com'
    click_button 'Log In'
    click_on 'Log Out'
    expect(page).to have_content('ALL EVENTS')
  end
end
