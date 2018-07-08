class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
  end
  
  # 検索結果から、必要な値を読みだして、最後にハッシュとしてreturnする。
  def read(result)
    # itemCode 楽天でのID
    code = result['itemCode']
    # itemName 商品名
    name = result['itemName']
    # itemUrl 商品の楽天でのURL
    url = result['itemUrl']
    # mediumImageUrls 商品の画像URL
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '' )
    
    # ハッシュとしてreturn
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
