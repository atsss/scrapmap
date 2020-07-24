class FrontController < ApplicationController
  layout 'front/application'

  before_action :authenticate_account!
end
