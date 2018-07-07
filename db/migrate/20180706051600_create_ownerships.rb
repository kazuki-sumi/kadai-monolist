class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      # typeがあるのはここにwantもしくはhaveを入れるため。WantもHave名称が違うだけで表現の形へ同じ。
      t.string :type
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
      
      # 下記は同一Userと同一itemに対して複数回Wantできないように課す制約
      t.index [:user_id, :item_id, :type], unique: true
    end
  end
end
