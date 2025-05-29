shared_context "task variables" do
  fixtures :states, 'wobauth/users'
  # -- states
  let!(:pending)  { states(:pending) }
  let!(:pre)     { states(:pre) }
  let!(:open)    { states(:open) }
  let!(:atwork)  { states(:atwork) }
  let!(:done)    { states(:done) }
  let!(:archive) { states(:archive) }

  # -- users
  let(:mmax) { wobauth_users(:mmax) }
  let(:mcaro) { wobauth_users(:mcaro) }

  # -- entities: org_units and lists
  let(:ou1)  { FactoryBot.create(:org_unit, name: "Mustermann GmbH" )}
  let(:ou11)  { FactoryBot.create(:org_unit, name: "Controlling", parent: ou1 )}
  let(:ou2)  { FactoryBot.create(:org_unit, name: "ACME Ltd" )}
  let(:list1) { FactoryBot.create(:list, name: "Mustermanns global list", org_unit: ou1)}
  let(:list2) { FactoryBot.create(:list, name: "ACME list", org_unit: ou2)}
  let(:list3) { FactoryBot.create(:list, name: "Caro's private list", user: mcaro)}
 
  # -- other stuff
  let(:ref)   { FactoryBot.create(:reference, url: "https://somehardstuff") }

  # -- tasks
  let!(:t1) { FactoryBot.create(:task,
    state: open,
    subject: "Maxs task",
    user: mmax,
    responsible: mmax,
    resubmission: "2020-07-01",
    deadline: "2020-08-10",
  )}
  let!(:t2) { FactoryBot.create(:task,
    state: open,
    subject: "Caros task",
    user: mcaro,
    responsible: mcaro,
    private: true,
  )}
  let!(:to1) { FactoryBot.create(:task,
    state: open,
    subject: "MM task",
    user: mmax,
    org_unit: ou1,
  )}
  let!(:to2) { FactoryBot.create(:task,
    state: open,
    subject: "ACME task",
    user: mcaro,
    org_unit: ou2,
    start: "2021-01-11",
  )}
  let!(:tl1) { FactoryBot.create(:task,
    state: open,
    subject: "MM global list task",
    list: list1,
    start: "2020-02-17",
    deadline: "2020-07-01",
    priority: 'high',
  )}
  let!(:tl2) { FactoryBot.create(:task,
    state: pending,
    subject: "ACME global list task",
    list: list2,
    start: "2020-07-17",
    deadline: "2020-12-24",
    priority: 'critical',
  )}
  let!(:xref) { FactoryBot.create(:cross_reference, 
    task: tl2, 
    identifier: "X4711",
    reference: ref
  )}
  let!(:done1) { FactoryBot.create(:task,
    state: done,
    subject: "Task1 done!",
    responsible: mmax,
    org_unit: ou11,
  )}
  let!(:archiv2) { FactoryBot.create(:task,
    state: archive,
    subject: "Task2 done!",
    responsible: mcaro,
    org_unit: ou11
  )}
end
