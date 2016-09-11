# == Schema Information
#
# Table name: items
#
#  id                        :integer          not null, primary key
#  name                      :string
#  kind                      :integer          default("topper")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  rare_class                :integer          default("common")
#  game_preview_file_name    :string
#  game_preview_content_type :string
#  game_preview_file_size    :integer
#  game_preview_updated_at   :datetime
#

class Item < ApplicationRecord
  enum kind: [:topper, :antenna, :wheels, :boost, :decal, :crate, 'battle-car']
  enum rare_class: [:common, :uncommon, :rare, :super_rare, :premium, :limited, :very_rare, :import, :exotic, :black_market]

  has_many :user_items, inverse_of: :item

  validates :name, uniqueness: { scope: :kind, case_sensitive: false }

  has_attached_file :game_preview,
    styles: { original: ["100%", :jpg] },
    path: "/images/:attachment/:id/:item_name:dotextension"

  validates_attachment_content_type :game_preview, content_type: /\Aimage\/.*\z/

  def self.default_scope
    order(name: :asc)
  end

  def s3_credentials
    { bucket: Settings.s3.bucket_name, access_key_id: ENV['GP_AWS_ACCESS_KEY_ID'], secret_access_key: ENV['GP_AWS_SECRET_KEY_ID'] }
  end

  private
    Paperclip.interpolates :item_name do |attachment, style|
      attachment.instance.name
    end
end
