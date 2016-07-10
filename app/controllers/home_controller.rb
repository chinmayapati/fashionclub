class HomeController < ApplicationController

  def index
  end

  def product
    @catagory = params[:catagory]
    @sub = params[:sub]
  end

  def cart
  end

  def checkout
  end

    def single_product

    end
end
