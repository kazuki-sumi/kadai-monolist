class Item < ApplicationRecord
    validates :code, presence: true, length: {maximum: 255}
    validates :name, presence: true, length: {maximum: 255}
    validates :url, presence: true, length: {maximum: 255}
    validates :image_url, presence: true, length: {maximum: 255}
    
    # item.ownershipsで中間テーブルのインスタンス群を取得
    has_many :ownerships
    # item.usersでitemをwant/haveしているusersを取得
    has_many :users,through: :ownerships
    
    has_many :wants
    # item.want_usersで、itemをWantしているusersを取得できる
    has_many :want_users, through: :wants, class_name: 'User', source: :user
end
