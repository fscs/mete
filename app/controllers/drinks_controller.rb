class DrinksController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  after_action only: [:create, :update, :destroy] do
     sign_out(current_admin) if current_admin
  end
  # GET /drinks
  def index
    @drinks = Drink.order(active: :desc).order("name COLLATE nocase")
    # index.html.haml
  end

  # GET /drinks/1
  def show
    @drink = Drink.find(params[:id])
    # show.html.haml
  end

  # GET /drinks/new
  def new
    @drink = Drink.new
    @drink.price = 1.2
    @drink.bottle_size = 1
    @drink.caffeine = 0
    # new.html.haml
  end

  # GET /drinks/1/edit
  def edit
    @drink = Drink.find(params[:id])
    # edit.html.haml
  end

  # POST /drinks
  def create
    @drink = Drink.new(drink_params)
    if @drink.save
      flash[:success] = "Drink was successfully created."
      no_resp_redir drinks_url
    else
      render action: "new", error: "Couldn't create the drink. Error: #{@drink.errors} Status: #{:unprocessable_entity}"
    end
  end

  # PATCH /drinks/1
  def update
    @drink = Drink.find(params[:id])
    if @drink.update_attributes(drink_params)
      flash[:success] = "Drink was successfully updated."
      no_resp_redir drinks_url
    else
      render action: "edit", error: "Couldn't update the drink. Error: #{@drink.errors} Status: #{:unprocessable_entity}"
    end
  end

  # DELETE /drinks/1
  def destroy
    @drink = Drink.find(params[:id])
    Barcode.where(:drink => @drink.id).each do |barcode|
      barcode.destroy!
      flash[:info] = "Deleted all barcodes for this drink."
    end
    if @drink.destroy
      flash[:success] = "Drink was successfully deleted."
      no_resp_redir drinks_url
    else
      redirect_to drinks_url, error: "Couldn't delete the drink. Error: #{@drink.errors} Status: #{:unprocessable_entity}"
    end
  end

  private

  def drink_params
    params.require(:drink).permit(:bottle_size, :caffeine, :price, :logo, :name, :active)
  end
end
