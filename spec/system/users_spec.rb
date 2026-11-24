require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ユーザー登録機能" do
    context "ページ遷移確認" do
      it "トップページからユーザー登録画面へのアクセスが成功するか" do
        visit root_path
        find(".top-register-link").click
        expect(current_path).to eq new_user_registration_path
        expect(page).to have_selector("#user_nickname")
        expect(page).to have_selector("#user_email")
        expect(page).to have_selector("#user_password")
        expect(page).to have_selector("#user_password_confirmation")
      end
    end

    context "ユーザー登録" do
      it "ユーザー登録が成功して、トップページに遷移したら成功" do
        visit new_user_registration_path
        find("#user_nickname").set("テスト")
        find("#user_email").set("test@example.com")
        find("#user_password").set("passwordpassword")
        find("#user_password_confirmation").set("passwordpassword")
        find(".wk-btn-primary").click
        expect(page).to have_css("#mood")
        expect(page).to have_content("Wow！な料理で日常にWow！を")
        # expect(current_path).to eq root_pathだと遷移が追いつかずエラーになった。
        # have_current_pathは画面遷移やJavaScriptの処理が完了するまで自動で待機（リトライ）してくれるから確実
        expect(page).to have_current_path(root_path)
      end

      it "ユーザー登録が失敗して、ページに止まっていれば成功" do
        visit new_user_registration_path
        find(".wk-btn-primary").click
        expect(page).to have_css("#error_explanation")
        expect(page).to have_current_path(new_user_registration_path)
      end
    end
  end
end
