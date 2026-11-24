require 'rails_helper'

  RSpec.describe User, type: :model do
    describe "userモデルのテスト" do
      context "user新規作成" do
        it "全ての入力が正常で登録が成功する" do
          user = FactoryBot.build(:user)
          expect(user).to be_valid
        end

        it "nicknameが空欄だったらバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, nickname: nil)
          user.valid?
          expect(user.errors).to be_of_kind(:nickname, :blank)
        end

        it "emailが空欄だったらバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, email: nil)
          user.valid?
          expect(user.errors).to be_of_kind(:email, :blank)
        end

        it "emailが重複でバリデーションエラーが発生する" do
          user_1 = FactoryBot.create(:user, email: "test@example.com")
          user_2 = FactoryBot.build(:user, email: "test@example.com")
          user_2.valid?
          expect(user_2.errors).to be_of_kind(:email, :taken)
        end

        it "emailがメール正規表現に当てはまらない（＠前に文字列なし）とバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, email: "@example.com")
          user.valid?
          expect(user.errors).to be_of_kind(:email, :invalid)
        end

        it "emailがメール正規表現に当てはまらない（＠後に文字列なし）とバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, email: "test@")
          user.valid?
          expect(user.errors).to be_of_kind(:email, :invalid)
        end

        it "emailがメール正規表現に当てはまらない（＠がない）とバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, email: "test.example.com")
          user.valid?
          expect(user.errors).to be_of_kind(:email, :invalid)
        end

        it "passwordが空欄でバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, password: nil)
          user.valid?
          expect(user.errors).to be_of_kind(:password, :blank)
        end

        it "passwordが14文字でバリデーションエラーが発生する" do
          user = FactoryBot.build(:user, password: "12345678912345")
          user.valid?
          expect(user.errors).to be_of_kind(:password, :too_short)
        end

        it "passwordが15文字でユーザー登録が成功する" do
          user = FactoryBot.build(:user, password: "123456789123456")
          expect(user).to be_valid
        end
      end
    end
  end
