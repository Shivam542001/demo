class OrderNotificationMailer < ApplicationMailer

  def create_notification(order)
    @order = order
    user = User.find_by(id: order.user_id)
    mail to: user.email, subject: "new order created"
  end
end
