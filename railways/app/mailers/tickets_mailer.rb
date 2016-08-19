class TicketsMailer < ApplicationMailer
  def buy_ticket(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: user.email, subject: I18n.t('common.buying_message'))
  end

  def cancel_ticket(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: user.email, subjet: I18n.t('common.cancel_ticket'))
  end
end
