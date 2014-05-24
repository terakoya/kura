class RenameSecurePasswordColumnForHasSecurePassword < ActiveRecord::Migration
  def change
    rename_column :stuffs, :encrypted_password, :password_digest
  end
end
