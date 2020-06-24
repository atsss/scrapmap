class ApplicationService < ActiveInteraction::Base
  private

  def transaction(options = {}, &block)
    ActiveRecord::Base.transaction(options, &block)
  end
end
