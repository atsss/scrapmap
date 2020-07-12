module ApplicationHelper
  def map_tag
    content_tag(:div, style: 'width: 100%;') do
      content_tag(:div, nil, id: 'map', style: 'width: 100%; height: 400px;')
    end
  end

  def header(back_path=nil)
    content_for(:header) do
      render 'shared/organisms/header', back_path: back_path
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
