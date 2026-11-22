class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable
        # パスワードリセット（:recoverable）、ログイン保持（:rememberable）機能はMVPでは使わないためコメントアウト
        # 使うときにはカラムを追加する必要があることを覚えておく（20261122153729_devise_create_users.rb）でコメントアウトになっているのを確認
        #  :recoverable, :rememberable, 
end
