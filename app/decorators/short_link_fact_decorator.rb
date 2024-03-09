class ShortLinkFactDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def location
    info = Geocoder.search(object.ip).first
    info.country.present? ? "#{info.region}, #{info.country}" : "Unknown"
  end

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
