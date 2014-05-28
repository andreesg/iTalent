module ApplicationHelper
  def render_header?
    return true if (controller_name == 'devise/registrations' and action_name == 'new') or
      (controller_name == 'devise/registrations' and action_name == 'create') or
      (controller_name == 'devise/sessions' and action_name == 'new') or
      (controller_name == 'devise/sessions' and action_name == 'create')
    return true
  end

  def format_date(date)
    return date.strftime('%d/%m/%Y %H:%M')
  end
end
