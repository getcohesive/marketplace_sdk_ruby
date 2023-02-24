require "json"

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    puts request.env["auth_details"].user_name
    @user = request.env["auth_details"].to_h.to_json
  end
end
