# Preview all emails at http://localhost:3000/rails/mailers/note_mailer
class NoteMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/note_mailer/send_note
  def send_note
    NoteMailer.send_note(Note.first, mail_to: 'ticket@example.org', prefix: '4711')
  end

end
