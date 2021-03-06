module UsersHelper
  def platform_ion_class(platform_string)
    if platform_string == 'Steam'
      'ion-steam'
    elsif platform_string == 'PSN'
      'ion-playstation'
    elsif platform_string == 'Xbox'
      'ion-xbox'
    end
  end

  def platform_username_with_ion(platform_user)
    "<span class='platform-username-with-ion'><i class='icon #{platform_ion_class(platform_user.platform)}'></i>&nbsp;#{sanitize(platform_user.platform_username)}</span>".html_safe
  end

  def button_popover_for_user(user)
    popover_html = ""

    if user != current_user
      popover_html += "<button type='button' class='btn btn-primary message-button' data-toggle='modal' data-target='#message-modal' data-receiver-id='#{user.id}'>Message<span class='hidden-username'>#{sanitize(user.platform_username)}</span></button>"
    end

    popover_html += "<a id='popover-inventory-btn' class='btn btn-primary' href='#{platform_user_path(platform_string: user.platform.downcase, platform_username: user.platform_username)}'>Inventory</button>"

    h(popover_html)
  end
end
