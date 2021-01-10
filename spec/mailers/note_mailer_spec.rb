require "rails_helper"

RSpec.describe NoteMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user, 
    givenname: "Max", 
    sn: "Mustermann", 
    email: "mmax@mustermann.de"
  )}
  let(:task) { FactoryBot.create(:task, 
    subject: "Some Task",
    accountable: user
  )}
  let(:note) { FactoryBot.create(:note,
    user: user,
    date: '2020-02-02',
    description: "Some random description for some random task"
  )}

  describe "send_note" do
    let(:mail) { NoteMailer.send_note(note, mail_to: user.email, prefix: "8844" )}

    it "renders the headers" do
      expect(mail.subject).to eq("8844 Some Task")
      expect(mail.to).to eq(["mmax@mustermann.de"])
      expect(mail.from).to eq(Array(Titracka.mail_from))
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("2020-02-02")
      expect(mail.body.encoded).to match("Mustermann, Max")
      expect(mail.body.encoded).to match("Some random description for some random task")
    end
  end

end
