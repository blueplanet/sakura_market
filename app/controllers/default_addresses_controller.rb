class DefaultAddressesController < ApplicationController
  before_action :set_default_address, only: [:edit, :update]

  def update
    if @default_address.update default_address_params
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failed')
      render :edit
    end
  end

  private

  def set_default_address
    @default_address = current_user.default_address
  end

  def default_address_params
    params.require(:default_address).permit(:name, :tel, :zipcode, :address)
  end
end
