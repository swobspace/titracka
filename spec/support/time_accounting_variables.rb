shared_context "time_accounting variables" do
  fixtures 'wobauth/users', :tasks, :time_accountings, :states

  let!(:wday1) do
    FactoryBot.create(:workday,
      date: 1.day.before(Date.today),
      user: wobauth_users(:mmax) 
    )
  end
  let!(:task1) { tasks(:task1) }
  let!(:task2) { tasks(:task2) }

  let(:ta11) { time_accountings(:ta11) }
  let(:ta12) { time_accountings(:ta12) }
  let(:ta13) { time_accountings(:ta13) }
  let(:ta21) { time_accountings(:ta21) }
  let(:ta22) { time_accountings(:ta22) }

end
