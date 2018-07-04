class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      # 暗号化された文字列をダイジェストという。
      t.string :password_digest

      t.timestamps
    end
  end
end
