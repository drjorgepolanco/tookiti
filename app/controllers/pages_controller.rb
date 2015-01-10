class PagesController < ApplicationController
  before_action :user_info, only: :home
  
  def home
  end

  def about
  end

  def help
  end

  def contact
  end
end
