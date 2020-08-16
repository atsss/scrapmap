class FrontController < ApplicationController
  include Pundit

  layout 'front/application'

  before_action :authenticate_account!
  before_action :set_current_user
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  private

  def set_current_user
    @current_user = current_account.user
  end

  def pundit_user
    @current_user
  end
end
