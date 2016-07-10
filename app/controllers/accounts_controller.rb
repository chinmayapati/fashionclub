class AccountsController < ApplicationController
  def dashboard
    @current_view = 'Account Dashboard';
  end

  def profile
    @current_view = 'Personal Information';
  end

  def address
    @current_view = 'Address';
  end

  def addaddress
    @current_view = 'New Address';
  end

  def orders
    @current_view = 'Orders';
  end

  def singleorder
    @current_view = 'Single Order';
  end

  def wishlist
    @current_view = 'Wishlist';
  end

  def warranty
    @current_view = 'Warranty';
  end
end
