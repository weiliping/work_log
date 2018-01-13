class CreateApiClients < ActiveRecord::Migration[5.1]
  def change
    create_table :api_clients do |t|
      t.string :name
      t.string :app_token
      t.string :app_secret
      t.boolean :is_active

      t.timestamps
    end
  end
end
