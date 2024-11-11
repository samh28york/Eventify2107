class CreateOrganizers < ActiveRecord::Migration[7.2]
  def change
    create_table :organizers do |t|
      t.string :email, default: "", null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest, default: "", null: false

      t.timestamps
    end
  end
end
