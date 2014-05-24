class CreateStuffs < ActiveRecord::Migration
  def change
    create_table :stuffs do |t|
      t.string :title
      t.datetime :expires_at
      t.boolean :unlisted
      t.string :filename
      t.string :encrypted_password

      t.timestamps
    end
  end
end
