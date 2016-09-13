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
#  url_slug                  :string
#

class Item < ApplicationRecord
  enum kind: [:topper, :antenna, :wheels, :boost, :decal, :crate, 'battle-car']
  enum rare_class: {
    common: 0,
    uncommon: 1,
    rare: 2,  
    premium: 4,
    limited: 5,
    very_rare: 6,
    import: 7,
    exotic: 8,
    black_market: 9
  }

  has_many :user_items, inverse_of: :item

  validates :name, uniqueness: { scope: :kind, case_sensitive: false }

  has_attached_file :game_preview,
    styles: { original: ["100%", :jpg] },
    path: "/images/:attachment/:id/:item_name:dotextension",
    default_url: "https://#{Settings.s3.host_alias}/images/game_previews/missing.png",
    s3_headers: {
      'Cache-Control': 'max-age=31557600', 'Expires': 10.years.from_now.httpdate
    }

  validates_attachment_content_type :game_preview, content_type: /\Aimage\/.*\z/

  before_save :change_url_slug_if_name_changed

  def self.default_scope
    order(name: :asc)
  end

  def generated_url_slug
    self.name.downcase.gsub(" ", "-").gsub(/[\[\]\(\)]/, '').gsub(/-+/, '-')
  end

  private
    Paperclip.interpolates :item_name do |attachment, style|
      attachment.instance.name
    end

    def change_url_slug_if_name_changed
      self.url_slug = self.generated_url_slug if self.name_changed?
    end
end
