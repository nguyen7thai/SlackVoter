class ChangeColumnSlackServiceIdToSlackChannelId < ActiveRecord::Migration
  def change
    rename_column :surveys, :slack_service_id, :slack_channel_id
  end
end
