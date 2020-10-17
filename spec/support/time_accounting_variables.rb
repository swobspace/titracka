shared_context "time_accounting variables" do
  let!(:mmax) { FactoryBot.create(:user, 
    sn: "Mustermann", 
    givenname: "Max", 
    username: "mmax"
  )}

  let!(:mcaro) { FactoryBot.create(:user, 
    sn: "Mustermann", 
    givenname: "Carola", 
    username: "mcaro"
  )}

  let!(:wday1) { FactoryBot.create(:workday,
    date: 1.day.before(Date.today),
    user: mmax
  )}

  let!(:task1) { FactoryBot.create(:task, :open,
    subject: "Maxs task",
    user: mmax,
  )}

  let!(:task2) { FactoryBot.create(:task, :open,
    subject: "Caros task",
    user: mcaro,
  )}

  let!(:ta11) { FactoryBot.create(:time_accounting,
    user: mmax,
    task: task1,
    date: 1.day.before(Date.today),
    duration: 30,
  )}
  let!(:ta12) { FactoryBot.create(:time_accounting,
    user: mmax,
    task: task1,
    date: 2.day.before(Date.today),
    duration: 45,
  )}
  let!(:ta13) { FactoryBot.create(:time_accounting,
    user: mmax,
    task: task1,
    date: 1.day.before(Date.today),
    duration: 75,
  )}
  let!(:ta21) { FactoryBot.create(:time_accounting,
    user: mcaro,
    task: task2,
    date: 1.day.before(Date.today),
    duration: 13,
  )}
  let!(:ta22) { FactoryBot.create(:time_accounting,
    user: mcaro,
    task: task2,
    date: 1.week.before(Date.today),
    duration: 17,
  )}
end
