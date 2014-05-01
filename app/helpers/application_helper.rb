module ApplicationHelper
	def render_header?
		return true if (controller_name == 'devise/registrations' and action_name == 'new') or
			(controller_name == 'devise/registrations' and action_name == 'create') or
			(controller_name == 'devise/sessions' and action_name == 'new') or
			(controller_name == 'devise/sessions' and action_name == 'create')
		return false
	end
end
