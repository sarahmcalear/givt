class Api::V1::UsersController < ApplicationController
  def new
    # respond_to do |format|
    #   format.json
    # end
    @user = User.new
    render json: @user
  end

end
