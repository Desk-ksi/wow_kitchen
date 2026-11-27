class SearchesController < ApplicationController
  def create
    # app/services/llm_mood_changeで定義しているクラスをインスタンスにして、メソッドを使えるようにしている
    instance = LlmMoodChange.new()
    # llm_mood_changeに入力する情報をパラメーターから受け取っている
    mood = params[:mood]
    # llmが出力したSpoonacularAPIに渡すハッシュをsessionに保存
    session[:result] = instance.mood_change(mood)
    # ちゃんとLLMが出力しているかの確認をするためにログにセッションを出力する
    Rails.logger.info(session[:result])
    # 仮のリダイレクトパス
    redirect_to root_path
  end
end
