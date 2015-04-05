class AddSlackServiceIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :slack_service_id, :string
    add_index :surveys, :slack_service_id
  end
end
