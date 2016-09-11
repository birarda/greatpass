module ItemsHelper
  def cache_key_for_item_list
    count = Item.count
    max_updated_at = Item.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "items/all-#{count}-#{max_updated_at}"
  end
end
