class HomeController < ApplicationController

  def index
  end

  def product
    if !params[:cat].nil? and !params[:subcat].nil?
      @cat = params[:cat]
      @sub_cat = params[:subcat]
      @search_params = {category: @cat, subcat: @sub_cat}
      @search_result = Product.where(@search_params)

    else

      render file: "#{Rails.root}/public/404.html", :status => 404

    end


  end

  def cart
    cart_items = Cart.where(user_id: current_user.id, order_placed: 0).order('created_at DESC') # id,user_id,product_id,quantity
    product_ids = cart_items.map { |row| row.product_id } #.to_s.remove("[").remove("]")
    #product_data = Product.find_by_sql("SELECT id,images,name,tags,price,discount,sizes,quantity FROM `products` WHERE id IN (#{product_ids});") unless product_ids.empty?
    product_data=[]
    product_ids.size.times do |i|
      a=Product.find_by(id: product_ids[i])
      product_data << a
    end
    @cart_data ||= cart_items.zip product_data unless product_data.nil?
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
      o.payment_mode = session[:order]['payment_mode'] = params[:payment_mode]
      # preparing invoice
      total_discount = total = discount_price=0

      session[:order]["product_ids"].split(',').zip(session[:order]["quantity"].split(',')).each do |p, q|
        pr = Product.find_by(id: p.to_i)
        discount=((pr["discount"]/100.0)*pr["price"]).to_i
        total_discount += discount*q.to_i
        total += (pr["price"]-discount)*q.to_i
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



    if !params[:pid].nil?
      product_info=Product.find_by(id: params[:pid])

      if !product_info.nil?

        @category=product_info.category
        @category_c=@category.capitalize
        @brand=product_info.brand.capitalize
        @name=product_info.name
        @sub_cat=product_info.subcat
        @sub_cat_c=@sub_cat.gsub("_", " ").capitalize
        @discount=product_info.discount
        @image_path=product_info.images
        @rating=product_info.rating
        @price=product_info.price
        @discount=product_info.discount
        @after_discount=@price-((@discount/100.0)*@price).to_i
        @id=product_info.id
        @quantity=product_info.quantity
        @array=@quantity.split(/,/).map { |s| s.to_i }
        cnt=0
        @array.each { |x|
          if x==0
            cnt+=1
          end
        }
        if (cnt==@array.size)
          @stock=0
        else
          @stock=1
        end

        @tags=product_info.tags
        @brief=product_info.brief
        @sizes=product_info.sizes
        @sizes=@sizes.split(/,/)

        @desc1=product_info.desc1

        @desc2=product_info.desc2

      else
        render file: "#{Rails.root}/public/404.html", :status => 404
      end

    end


  end

  def stores

    if !params[:cartitem].nil? and !params[:cartitem].empty? and !params[:quantity].nil? and !params[:quantity].empty? and !params[:prosize].nil? and !params[:prosize].empty?

      if logged_in?
        if !Cart.exists?(user_id: current_user.id, product_id: params[:cartitem].to_i, order_placed: 0, size: params[:prosize])
          Cart.create(user_id: current_user.id, product_id: params[:cartitem].to_i, quantity: params[:quantity].to_i, size: params[:prosize])
        else
          Cart.exists(user_id: current_user.id, product_id: params[:cartitem].to_i, order_placed: 0, size: params[:prosize])
        end

      end
    end


    if !params[:wishlistitem].nil? and !params[:wishlistitem].empty?
      if logged_in?
        if !Wishlist.exists?(product_id: params[:wishlistitem].to_i, user_id: current_user.id)
        Wishlist.create(user_id: current_user.id, product_id: params[:wishlistitem].to_i)
      else
        Wishlist.exists(product_id: params[:wishlistitem].to_i, user_id: current_user.id)
      end
      end

    end
    end

  def tac


  end

  def privacy
  end

end