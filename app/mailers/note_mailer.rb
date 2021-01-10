class NoteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.note_mailer.send_note.subject
  #
  def send_note(note, options = {})
    @note = note
    options = options.symbolize_keys
    mail_from = options.fetch(:mail_from) { Titracka.mail_from }
    mail_to = options.fetch(:mail_to)
    prefix  = options.fetch(:prefix) { "" }
    subject = options.fetch(:subject) { @note.task.subject }

    mail from: mail_from, to: mail_to, subject: [prefix, subject].compact.join(" ")
  end
end
