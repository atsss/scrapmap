module ApplicationHelper
  def map_tag
    content_tag(:div, style: 'width: 800px;') do
      content_tag(:div, nil, id: 'map', style: 'width: 800px; height: 400px;')
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
end
