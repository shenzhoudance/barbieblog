module ApplicationHelper

  # if on active page color = white
  # if not on active page color = require
  # take arguments: 'link','what page its on','url''change font color'

  def active_link_to(nav_link, contrl, action, url, style)
    if controller_name == contrl && action_name == action
      return link_to nav_link, url, id: style
    else
      return link_to nav_link, url, class: style
    end
  end
end
