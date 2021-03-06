class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :order_params, only: [:create, :update]

  # GET /orders
  # GET /orders.json
  def index
    # @orders = Order.all
    # @orders = Order.where(user_id: current_user.id)
    @orders = Order.joins(:users).where(users: {id: current_user.id}).paginate(page: params[:page], per_page: 2)
    @myOrders = Order.where(user_id: current_user.id).paginate(page: params[:page], per_page: 2)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @invited_friends = User.joins(:orders).where(orders: {id: params[:id]})
  end

  # GET /orders/new
  def new
    @order = Order.new
    @users = Friendship.where(user_id: current_user.id)
  end

  # GET /orders/1/edit
  def edit
    @users = Friendship.where(user_id: current_user.id)
  end


  # POST /orders
  # POST /orders.json
  def create
    @user = current_user
    @order = @user.order.new(order_params)

    # @friend = User.find(order_friend['friend'])
    # @friend.orders << @order
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        # format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        # format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    # @user = current_user
    # @order = @user.order.new(order_params)
    @order = Order.find(params[:id])
    @order.update_attributes(order_params)
    # @friend = User.find(order_friend['friend'])
    # @friend.orders << @order
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :orderType, :orderFrom, :image, :user_ids => [])
    end
end
