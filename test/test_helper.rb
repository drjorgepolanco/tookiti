ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class CarrierWave::Mount::Mounter
  def store!
  end
end

class ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  fixtures :all

  CarrierWave.root = Rails.root.join('test/fixtures')

  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end

  def is_logged_in?
  	!session[:user_id].nil?
  end

  def log_in_as(user, options = {})
  	password    = options[:password]    || 'password'
  	remember_me = options[:remember_me] || '1'
  	if integration_test?
  		post login_path, session: { email:       user.email,
  		                            password:    password,
  		                            remember_me: remember_me }
  	else
  		session[:user_id] = user.id
  	end
  end

  private

  	def integration_test?
  		defined?(post_via_redirect)
  	end
end
