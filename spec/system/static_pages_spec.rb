require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    before { visit root_path }
    it "トップページに遷移できれば成功" do
      expect(current_path).to eq root_path
    end
    it "トップページにmood入力フォームがあれば成功" do
      expect(page).to have_css("#mood")
    end
    it "トップページにWow！な料理で日常にWow！をという文字列があれば成功" do
      expect(page).to have_content("Wow！な料理で日常にWow！を")
    end
  end
end
