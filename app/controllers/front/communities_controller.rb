module Front
  class CommunitiesController < FrontController
    before_action :set_community

    def show
      authorize @community
    end

    private

    def set_community
      @community = if params[:id]
                     @current_user.communities.where(id: params[:id]).last
                   else
                     @current_user.private_community
                   end
    end
  end
end
