class AddressesController < ApplicationController
  before_action :authenticate_user
  before_action :set_addresses
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /addresses
  def index
    render json: @addresses, only: [:id, :name, :line1, :line2, :mobile],
                                include: { location: { only: [:id, :name] }}
  end

  # GET /addresses/1
  def show
    render json: @address, only: [:id, :name, :line1, :line2, :mobile],
                                include: { location: { only: [:id, :name] }}
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    @address.user = current_user

    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = @addresses.find(params[:id])
    end

    def set_addresses
      @addresses = current_user.addresses
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.fetch(:address, {}).permit(:name, :line1, :line2, :location_id, :mobile)
    end
end
