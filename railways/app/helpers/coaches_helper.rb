module CoachesHelper
  def sti_coach_path(type = "coach", coach = nil, action = nil)
    send "#{format_sti(action, type, coach)}_path", coach
  end
   
  def format_sti(action, type, coach)
    action || coach ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
   
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
