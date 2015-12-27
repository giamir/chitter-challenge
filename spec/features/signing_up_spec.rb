# As a Maker
# So that I can post messages on Chitter as me
# I want to sign up for Chitter

feature 'Creating a new account' do
  scenario 'redirects to the sign in page' do
    sign_up
    expect(current_path).to eq '/sessions/new'
  end

  scenario 'user count increases by 1' do
    expect { sign_up }.to change { User.count }.by(1)
  end

  scenario 'if sign up with same credentials user count do not increase' do
    sign_up
    expect { sign_up }.to change { User.count }.by(0)
  end

  scenario 'if submitted name is blank display a message' do
    sign_up(name: '')
    expect(page).to have_content('Name must not be blank')
  end

  scenario 'if submitted username is blank display a message' do
    sign_up(username: '')
    expect(page).to have_content('Username must not be blank')
  end

  scenario 'if submitted email is blank display a message' do
    sign_up(email: '')
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'if submitted email is invalid display a message' do
    sign_up(email: 'no_valid_email')
    expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'if submitted username is already in the database display a message' do
    sign_up
    sign_up(email: 'giamir_dup@email.com')
    expect(page).to have_content 'Username is already taken'
  end

  scenario 'if submitted email is already in the database display a message' do
    sign_up
    sign_up(username: 'giamir_dup')
    expect(page).to have_content 'Email is already taken'
  end
end
