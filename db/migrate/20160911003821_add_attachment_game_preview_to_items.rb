class AddAttachmentGamePreviewToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :game_preview
    end
  end

  def self.down
    remove_attachment :items, :game_preview
  end
end
