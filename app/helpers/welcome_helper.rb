module WelcomeHelper
  def resource_name
    :group
  end

  def resource
    @resource ||= Group.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:group]
  end
end
