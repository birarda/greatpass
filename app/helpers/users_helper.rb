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
end
