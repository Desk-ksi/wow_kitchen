# 各テストで繰り返し使用する処理をモジュールにして継承することで、何度も処理を書かなくてもよくなる
module SessionMacros
  # ログインの処理をメソッドにする。各システムテストのファイルで読み込み（include SessionMacros）をして、login(user)メソッドを使えばログインする
  def login(user)
    visit new_user_session_path
    find("#user_email").set(user.email)
    find("#user_password").set(user.password)
    click_on "ログインする"
  end
end
