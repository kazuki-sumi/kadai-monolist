class User < ApplicationRecord
    before_save {self.email.downcase!}
    #バリデーションをかけ、nameはカラを許さずかつ長さは50文字以内
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255},
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
    # user.ownershipsで中間テーブルのインスタンス群を取得
    has_many :ownerships
    # user.itemsでuserがwant/haveしているitemsを取得
    has_many :items, through: :ownerships
    
    has_many :wants
    # Wantしたitemだけをuser.want_itemsで取得できる
    has_many :want_items, through: :wants, class_name: 'Item', source: :item
    has_secure_password
    
    def want(item)
        self.wants.find_or_create_by(item_id: item.id)
    end
    
    def unwant(item)
        want = self.wants.find_by(item_id: item.id)
        want.destroy if want
    end
    
    def want?(item)
        self.want_items.include?(item)
    end
end
