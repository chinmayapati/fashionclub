class HomeController < ApplicationController

  def index
  end

  def product
    if !params[:cat].nil? and !params[:sub].nil?
      cat = params[:cat]
      sub_cat = params[:sub]
      @search_params = {category: cat, subcat: sub_cat}
      @search_result = Product.where(@search_params)
    end
  end

  def cart
    cart_items = Cart.where(user_id: current_user.id, order_placed: 0) # id,user_id,product_id,quantity
    product_ids = cart_items.map { |row| row.product_id }.to_s.remove("[").remove("]")
    product_data = Product.find_by_sql("SELECT id,images,name,tags,price,discount,sizes,quantity FROM `products` WHERE id IN (#{product_ids});") unless product_ids.empty?
    @cart_data ||= cart_items.zip product_data unless product_data.nil?
    debugger
    if !params[:cart_id].nil? and !params[:quantity].nil?
      if logged_in?
        cart_id = params[:cart_id].map { |i| i.to_i }
        quantity = params[:quantity].map { |i| i.to_i }
        to_update = cart_id.zip quantity
        to_update.each do |c, q|
          Cart.find_by(id: c).update_column("quantity", q)
        end
      end
    end

    if !params[:cart_id].nil? and logged_in?
      Cart.delete(params[:cart_id].to_i)
    end

  end

  def checkout
    if logged_in?
      @address = Address.where(user_id: current_user.id)
      if !params[:billing_addr_info].nil? and !params[:billing_addr_info].empty?
        data = params[:billing_addr_info]
        if !data.nil?
          data[:user_id] = current_user.id
          cart = Cart.where(user_id: current_user.id, order_placed: 0)
          q = []; p = []
          for i in cart
            q.push(i.quantity); p.push(i.product_id)
          end
          data[:quantity] = q.join(',')
          data[:product_ids] = p.join(',')
          session[:order] = data
          session[:order]["tax"] = 14.36
        end
      end
    end
  end

  def payment
    if !params[:payment_mode].nil? and !params[:payment_mode].empty?
      o = Order.new(Hash[session[:order].map { |a, b| [a, b] }])
      o.payment_method = session[:order]['paymeny_mode'] = params[:payment_mode]

      # preparing invoice
      total_discount = total = 0
      session[:order]["product_ids"].split(',').zip(session[:order]["quantity"].split(',')).each do |p, q|
        pr = Product.find_by(id: p.to_i)
        total_discount += (pr["discount"] * pr["price"]/100)*q.to_i
        total += (pr["price"] - pr["discount"]*pr["price"]/100)*q.to_i
      end
      o.total_discount = session[:order]["total_discount"] = total_discount.to_i
      o.total = session[:order]["total"] = total.to_i

      if o.save
        session[:order]["id"] = o.id
        Cart.where(user_id: current_user.id, order_placed: 0).each do |c|
          c.update_column("order_placed", 1)
        end
      end

    end
  end

  def review
    if !session[:order].nil?
      @order_review = session[:order]
    else
      @order_review = nil
      session.delete(:order)
      redirect_to root_url
    end
    @product_data = []
    session[:order]["product_ids"].split(',').zip(session[:order]["quantity"].split(',')).each do |pid, q|
      p = Product.find_by(id: pid.to_i)
      p.quantity = q
      @product_data.push(p)
    end

  end

  def single_product
  end

  def stores
  end

  def tac
  end

  def privacy
  end

end