# frozen_string_literal: true

module NavigationHelper
  def render_sidenav_item(label:, icon:, link:, active: false)
    link_to(link, { class: sidenav_item_class(active: active) }) do
      icon(name: icon, colour: :gray, active: active) << label
    end
  end

  private

  def sidenav_item_class(active:)
    [
      (active ? active_sidenav_item_class : inactive_sidenav_item_class).to_s,
      'group flex items-center px-2 py-2 text-sm font-medium rounded-md'
    ].join(' ')
  end

  def active_sidenav_item_class
    'bg-gray-900 text-white'
  end

  def inactive_sidenav_item_class
    'text-gray-300 hover:bg-gray-700 hover:text-white'
  end
end
