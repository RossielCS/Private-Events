require 'rails_helper'

RSpec.describe 'Events', type: :feature do
  before :each do
    User.create(username: 'Alex', email: 'alex@mail.com')
  end
  subject(:other_user) { User.create(username: 'Jessica', email: 'jessica@mail.com') }

  it 'creates an event without attendees' do
    visit login_path
    fill_in 'session[email]', with: 'alex@mail.com'
    click_button 'Log In'
    expect(page).to have_content('Hi Alex')
    click_on 'Create an Event'
    expect(page).to have_content('Hi Alex')
    expect(page).to have_content('Create a New Event')
    expect(page).to have_content('Describe the event')
    expect(page).to have_content('Location')
    expect(page).to have_content('Date')
    expect(page).to have_content("There aren't registered users to invite to the event.")
    fill_in 'event[description]', with: 'Alex\'s pool party.'
    fill_in 'event[location]', with: 'Alex\'s House'
    fill_in 'event[date]', with: '2020/08/13'
    click_button 'Create!'
    expect(page).to have_content('Event was successfully created.')
  end

  it 'creates an event with attendees' do
    visit login_path
    fill_in 'session[email]', with: other_user.email
    click_button 'Log In'
    expect(page).to have_content('Hi Jessica')
    click_on 'Create an Event'
    expect(page).to have_content('Hi Jessica')
    expect(page).to have_content('Create a New Event')
    expect(page).to have_content('Describe the event')
    expect(page).to have_content('Location')
    expect(page).to have_content('Date')
    expect(page).to have_content('Select the users to invite to the event.')
    fill_in 'event[description]', with: 'Jessica\'s Birthday Party.'
    fill_in 'event[location]', with: 'Jessica\'s House'
    fill_in 'event[date]', with: '2020/09/17'
    click_button 'Create!'
    expect(page).to have_content('Event was successfully created.')
  end

  it 'shows the invitations' do
    visit login_path
    fill_in 'session[email]', with: other_user.email
    click_button 'Log In'
    expect(page).to have_content('Hi Jessica')
    click_on 'Create an Event'
    expect(page).to have_content('Hi Jessica')
    expect(page).to have_content('Create a New Event')
    expect(page).to have_content('Describe the event')
    expect(page).to have_content('Location')
    expect(page).to have_content('Date')
    expect(page).to have_content('Select the users to invite to the event.')
    fill_in 'event[description]', with: 'Jessica\'s Birthday Party.'
    fill_in 'event[location]', with: 'Jessica\'s House'
    fill_in 'event[date]', with: '2020/09/17'
    click_button 'Create!'
    click_on 'Log Out'
    click_on 'Log In'
    fill_in 'session[email]', with: 'alex@mail.com'
    click_button 'Log In'
    expect(page).to have_content('Hi Alex')
    expect(page).to have_content('Invitations')
    expect(page).to have_content('Jessica\'s Birthday Party.')
  end

  it 'shows the events show page' do
    visit login_path
    fill_in 'session[email]', with: other_user.email
    click_button 'Log In'
    expect(page).to have_content('Hi Jessica')
    click_on 'Create an Event'
    expect(page).to have_content('Hi Jessica')
    expect(page).to have_content('Create a New Event')
    expect(page).to have_content('Describe the event')
    expect(page).to have_content('Location')
    expect(page).to have_content('Date')
    expect(page).to have_content('Select the users to invite to the event.')
    fill_in 'event[description]', with: 'Jessica\'s Anniversary.'
    fill_in 'event[location]', with: 'Jessica\'s House.'
    fill_in 'event[date]', with: '2020/09/17'
    click_button 'Create!'
    expect(page).to have_content('Event was successfully created.')
    expect(page).to have_content('Hi Jessica')
    expect(page).to have_content('Your Events')
    expect(page).to have_content('Description')
    expect(page).to have_content('Jessica\'s Anniversary.')
    expect(page).to have_content('Attendees')
    expect(page).to have_content('Alex')
  end
end
