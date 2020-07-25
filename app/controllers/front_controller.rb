class FrontController < ApplicationController
  layout 'front/application'

  before_action :authenticate_account!
  before_action :set_current_user

  private

  def set_current_user
    @current_user = current_account.user
  end
end
