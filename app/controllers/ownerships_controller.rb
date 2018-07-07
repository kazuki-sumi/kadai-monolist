class OwnershipsController < ApplicationController
  def create
    # Item.find_or_initialize_byについて
    # Item.find_byして見つかればテーブルに保存されているインスタンスを返す
    # なければItem.newして新規作成するメソッド
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    # persisted? 保存済みかどうかチェックする
    unless @item.persisted?
      # itemCode 楽天でのID 
      # @itemが保存されていない場合、先に@itemを保存する
      # IDを配列として返す
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      
      @item = Item.new(read(result.first))
      @item.save
    end
    
    # Want関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品をWantしました。'
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品のWantを解除しました。'
    end
    
    redirect_back(fallback_location: root_path)
  end
end
