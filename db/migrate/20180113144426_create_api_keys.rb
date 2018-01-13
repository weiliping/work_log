class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :user_id
      t.integer :api_client_id
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
