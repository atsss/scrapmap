module ApplicationHelper
  def map_tag
    content_tag(:div, style: 'width: 100%;') do
      content_tag(:div, nil, id: 'map', style: 'width: 100%; height: 400px;')
    end
  end

  def header(back_path = nil)
    content_for(:header) do
      render 'shared/organisms/header', back_path: back_path
    end
  end

  def nav(place = nil)
    add_path = new_place_note_path(place)
    route_path = place.google_map_url || google_map_url(lat: place.lat, lng: place.lng)
    order_path = place.uber_eats_url

    content_for(:nav) do
      render 'shared/organisms/nav',
             route_path: route_path,
             add_path: add_path,
             order_path: order_path
    end
  end

  def resize_image(image:, width:, height:)
    image.variant(resize_to_fill: [width, height]).processed
  end

  def cdn_path(attachment)
    service = Rails.application.config.active_storage.service

    if service == :amazon
      key = attachment&.blob&.key
      "#{Settings.cloudfront.url}/#{key}"
    else
      attachment
    end
  end

  def js_bootstrap_tag
    content_tag(
      :div,
      nil,
      id: 'js-bootstrap',
      data: {
        controller: controller_path.split(%r{\/|_}).map(&:capitalize).join(''),
        action_name: action_name,
        vars: @js_vars.to_json
      }
    )
  end

  private

  def google_map_url(lat: nil, lng: nil)
    return nil if lat.nil? && lng.nil?

    "https://www.google.com/maps?q=#{lat},#{lng}"
  end
end
