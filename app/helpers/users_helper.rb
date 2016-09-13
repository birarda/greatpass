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
    "<span class='platform-username-with-ion'><i class='icon #{platform_ion_class(platform_user.platform)}'></i>&nbsp;#{platform_user.platform_username}</span>".html_safe
  end
end
