class ToppagesController < ApplicationController
  def index
    # Itemのインスタンスを作った順番に並べる
    @items = Item.order('updated_at DESC')
  end
end
