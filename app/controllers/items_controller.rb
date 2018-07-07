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
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      #
      results.each do |result|
        # 既に保存されている Item に関しては、 item.id の値も含めたいからです。
        # この item.id はフォームから Unwant するときに使用します。
        item = Item.find_or_initialize_by(read(result))
        # <<で@itemsの配列[]にitemを追加
        
        @items << item
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
  end
end
