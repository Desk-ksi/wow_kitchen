module SessionMacros
  def login(user)
    visit new_user_session_path
    find("#user_email").set(user.email)
    find("#user_password").set(user.password)
    click_on "ログインする"
  end
end