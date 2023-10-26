# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, if: -> { !request.format.json? }
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
