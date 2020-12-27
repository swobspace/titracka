shared_context "task variables" do
  let(:mmax) { FactoryBot.create(:user, 
    sn: "Mustermann", 
    givenname: "Max", 
    username: "mmax"
  )}

  let(:mcaro) { FactoryBot.create(:user, 
    sn: "Mustermann", 
    givenname: "Carola", 
    username: "mcaro"
  )}

  let(:pending) { FactoryBot.create(:state, name: "Warten auf", state: 'pending')}
  let(:ou1)  { FactoryBot.create(:org_unit, name: "Mustermann GmbH" )}
  let(:ou11)  { FactoryBot.create(:org_unit, name: "Controlling", parent: ou1 )}
  let(:ou2)  { FactoryBot.create(:org_unit, name: "ACME Ltd" )}
  let(:list1) { FactoryBot.create(:list, name: "Mustermanns global list", org_unit: ou1)}
  let(:list2) { FactoryBot.create(:list, name: "ACME list", org_unit: ou2)}
  let(:list3) { FactoryBot.create(:list, name: "Caro's private list", user: mcaro)}
  let(:ref)   { FactoryBot.create(:reference) }

  let!(:t1) { FactoryBot.create(:task, :open,
    subject: "Maxs task",
    user: mmax,
    responsible: mmax,
    resubmission: "2020-07-01",
    deadline: "2020-08-10",
  )}
  let!(:t2) { FactoryBot.create(:task, :open,
    subject: "Caros task",
    user: mcaro,
    responsible: mcaro,
    private: true,
  )}
  let!(:to1) { FactoryBot.create(:task, :open, 
    subject: "MM task",
    user: mmax,
    org_unit: ou1,
  )}
  let!(:to2) { FactoryBot.create(:task, :open, 
    subject: "ACME task",
    user: mcaro,
    org_unit: ou2,
    start: "2021-01-11",
  )}
  let!(:tl1) { FactoryBot.create(:task, :open, 
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
  let!(:xref) { FactoryBot.create(:cross_reference, task: tl2, reference: ref) }
  let!(:done1) { FactoryBot.create(:task, :done,
    subject: "Task1 done!",
    responsible: mmax,
    org_unit: ou11,
  )}
  let!(:archiv2) { FactoryBot.create(:task, :archive,
    subject: "Task2 done!",
    responsible: mcaro,
    org_unit: ou11
  )}
end
