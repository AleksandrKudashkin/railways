module CoachesHelper
  def sti_coach_path(train, type = "coach", coach = nil, action = nil)
      send "#{format_sti(train, action, type, coach)}_path", coach, train_id: train
  end
   
  def format_sti(train, action, type, coach)
    action || coach ? "#{format_action(action)}#{format_train(train)}#{type.underscore}" : "#{format_train(train)}#{type.underscore.pluralize}"
  end

  def format_train(train)
    train ? "train_" : ""
  end
   
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
