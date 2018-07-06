class ItemsController < ApplicationController
  before_action :require_user_logged_in
   
  def new
    # @itemsをカラの配列として初期化
    # @itemsに値が入るのは検索ワードが入力されたときだけ
    @items = []
    
    # フォームから送信される検索ワードを取得。
    # text_field_tag :keywordから受け取る
    @keyword = params[:keyword]
    # 検索結果をresultに代入
    if @keyword.paresent?
      results = RakutenWebService::Ichiba::Item.serch({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      #
      results.each do |result|
        # 扱い易いようにItemとしてインスタンスを作成
        # 保存はしない
        item = Item.new(read(result))
        # <<で@itemsの配列[]にitemを追加
        
        @items << item
      end
    end
  end
  
  private
  
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
