class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :slack_user_name
      t.string :choice
      t.timestamps null: false
    end

    add_reference :votes, :survey, index: true
  end
end
