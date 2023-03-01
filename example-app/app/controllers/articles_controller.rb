require "json"

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    if request.env["auth_details"]
      puts request.env["auth_details"].user_name
      @user = request.env["auth_details"].to_h.to_json
    else
      @user = "empty"
      puts request.env["auth_details"]
    end
  end
end
