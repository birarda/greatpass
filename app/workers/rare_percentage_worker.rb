class RarePercentageWorker
  include Sidekiq::Worker

  def perform
    ItemVariant.all.each do |variant|
      [:inventory, :wishlist].each do |list|
        total_item_count =
          UserItem.where({
            item_id: variant.item_id,
            certification: variant.certification,
            paint_color: variant.paint_color,
            list: UserItem.lists[list]
          }).count('DISTINCT user_id')

        listed_percentage = 0

        if total_item_count != 0
          total_users = User.count
          listed_percentage = 100 * (total_item_count.to_f / total_users)
        end

        variant.update_attribute(list == :inventory ? :inventory_percentage : :wishlist_percentage, listed_percentage)
      end
    end
  end
end
