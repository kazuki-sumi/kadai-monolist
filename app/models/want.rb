class Want < Ownership
    # def self.ranking クラスメソッド
    # Want.rankingのように(インスタンスではなく)クラス自体から呼び出せるメソッド
    # self.rankingはdef Want.rankingと同じ意味
    def self.ranking
        self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
    end
end
