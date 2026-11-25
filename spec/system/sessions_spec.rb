require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  include SessionMacros
  describe "ログイン機能" do
    context "ログイン機能のテスト" do
      let(:user) { FactoryBot.create(:user) }
      it "正規に入力してログインに成功する" do
        login(user)
        expect(page).to have_css("#mood")
        expect(page).to have_content("Wow！な料理で日常にWow！を")
        expect(page).to have_selector(".alert-success")
        expect(page).to have_selector("#header-logout-button")
        expect(page).to have_content("ログインしました。")
        expect(page).to have_current_path(root_path)
      end

      it "メールアドレスを入力せずにログインに失敗" do
        visit new_user_session_path
        find("#user_password").set(user.password)
        click_on "ログインする"
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_selector(".alert-danger")
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end

      it "パスワードを入力せずにログインに失敗" do
        visit new_user_session_path
        find("#user_email").set(user.email)
        click_on "ログインする"
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_selector(".alert-danger")
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end

    # ヘッダーのログインボタンとユーザー登録ページのログイン遷移リンクにテストしやすいようにidを付与
    context "ログインページへの遷移テスト" do
      it "ヘッダーのログインボタンでログインページへ遷移したら成功" do
        visit root_path
        find("#header-login-button").click
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_selector("#user_email")
        expect(page).to have_selector("#user_password")
      end

      it "ユーザー登録ページのログイン画面へのリンクでログインページへ遷移したら成功" do
        visit new_user_registration_path
        find("#new-user-login-link").click
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_selector("#user_email")
        expect(page).to have_selector("#user_password")
      end
    end
  end
end
