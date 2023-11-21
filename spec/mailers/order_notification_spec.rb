require "rails_helper"

RSpec.describe OrderNotificationMailer, type: :mailer do
  describe "create_notification" do
    let(:mail) { OrderNotificationMailer.create_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Create notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
