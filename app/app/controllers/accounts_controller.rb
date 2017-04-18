class AccountsController < ApplicationController

  $errors = []

  def index
  end

  def create

  end

  def show
  end

  def dashboard
    @current_view = 'Account Dashboard'
  end

  def profile
    @current_view = 'Personal Information'
    update_items = params[:profile]
    if !update_items.nil? and validate?(update_items)
      # Update in ActiveRecord
      user = User.find_by(id: current_user.id)
      password = update_items[:new_password].empty? ? nil : gethash(update_items[:new_password])
      user.update_column(:password, password) unless password.nil?
      redirect_to 'profile'
    else
      # Don't update and render profile to show $errors
      render 'profile'
    end
  end

  def address
    @current_view = 'Address'
    @users_addresses = Address.where(user_id: current_user.id)

    if params[:delete]=="1"
      delete_addr(params[:sn])
    end

  end

  def addaddress
    @current_view = 'New Address'
    addr_info = params[:new_addr]
    @addr = Address.new
    if !addr_info.nil?
      @addr = Address.new(add_new_addr_params)
      @addr.user_id = current_user.id
      if @addr.save
        redirect_to '/accounts/address'
      else
        render 'addaddress'
      end
    end

    if params[:edit]=="1"
      id = params[:sn]
      @edit_record = Address.find_by(id: id)
    end

  end

  def orders
    @current_view = 'Orders'
    @orders = Order.where(user_id: current_user.id)
    for order in @orders
      order[:quantity] = order[:quantity].split(",").map { |val| val.to_i }.sum
    end
  end

  def singleorder
    @current_view = 'Single Order'

    # Viewing an order
    if !params[:user_auth].nil? and !params[:order_id].nil?
      unless params[:user_auth].empty? and params[:order_id].empty?
        if logged_in? and (params[:user_auth] == current_user.id.to_s)
          @order_data = Order.find_by(id: params[:order_id])
          @product_data = Product.find_by_sql("SELECT images,name,tags,price,discount FROM `products` WHERE id IN (#{@order_data.product_ids})")
          quantity = @order_data[:quantity].split(",").map { |i| i.to_i }
          for i in 0...quantity.size
            @product_data[i][:quantity] = quantity[i].to_i
          end
        else
          redirect_to signin_path
        end
      end

    # Cancelling a order
    elsif !params[:cancel].nil? and !params[:o_id].nil? and !params[:u_auth].nil?
      if params[:cancel]=="1" and !params[:o_id].empty?
        if logged_in? and (params[:u_auth] == current_user.id.to_s)
          order = Order.find_by(id: params[:o_id])
          order.update_column("order_status", "Cancelled")
          redirect_to '/accounts/orders'
        end
      end
    else
      redirect_to '/accounts/orders'
    end

  end

  def wishlist

    @current_view = 'Wishlist'
    @wishlist_items = Product.find_by_sql("SELECT `wishlists`.id as w_id,`products`.id as p_id,images,name,brand,tags,discount,price FROM `wishlists` INNER JOIN products on `wishlists`.user_id=#{current_user.id} AND `wishlists`.product_id=`products`.id")
    # debugger

    unless params[:clear].nil?
      if logged_in?
        if params[:clear]=="a"
          @wishlist_items.each { |item| Wishlist.delete(item.w_id) }
        else
          Wishlist.delete(params[:clear])
        end
        redirect_to :back
      end
    end


  end

  def warranty
    @current_view = 'Warranty'
  end

  private
  def validate?(update_items)
    if update_items[:first_name].empty? || update_items[:last_name].empty?
      $errors.push("Invalid name") if $errors.index("Invalid name").nil?
    else
      $errors.delete("Invalid name") unless $errors.index("Invalid name").nil?
    end


    # Password validations
    unless update_items[:old_password].empty? and update_items[:new_password].empty? and update_items[:confirm_password].empty?
      if gethash(update_items[:old_password]) != current_user.password
        $errors.push("Invalid old password") if $errors.index("Invalid old password").nil?
      else
        $errors.delete("Invalid old password") unless $errors.index("Invalid old password").nil?
      end
      # New Password and Confirmation
      unless update_items[:new_password].length<6
        $errors.delete("Minimum password length is 6") unless $errors.index("Minimum password length is 6").nil?
        if update_items[:new_password] != update_items[:confirm_password]
          $errors.push("Passwords don't match") if $errors.index("Passwords don't match").nil?
        else
          $errors.delete("Passwords don't match") unless $errors.index("Passwords don't match").nil?
        end
      else
        $errors.push("Minimum password length is 6") if $errors.index("Minimum password length is 6").nil?
      end
    else
      $errors.delete("Invalid old password") unless $errors.index("Invalid old password").nil?
      $errors.delete("Passwords don't match") unless $errors.index("Passwords don't match").nil?
      $errors.delete("Minimum password length is 6") unless $errors.index("Minimum password length is 6").nil?
    end
    # debugger
    $errors.empty?
  end

  def gethash(text)
    Digest::MD5::hexdigest(text)
  end

  def add_new_addr_params
    params.require(:new_addr).permit(:first_name, :last_name, :phone, :address_one, :address_two, :city, :zipcode, :country)
  end

  def delete_addr(id)
    Address.delete(id)
    redirect_to :back
  end

end
