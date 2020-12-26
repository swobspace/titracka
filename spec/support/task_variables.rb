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

  let(:ou1)  { FactoryBot.create(:org_unit, name: "Mustermann GmbH" )}
  let(:ou2)  { FactoryBot.create(:org_unit, name: "ACME Ltd" )}
  let(:list1) { FactoryBot.create(:list, name: "Mustermanns global list", org_unit: ou1)}
  let(:list2) { FactoryBot.create(:list, name: "ACME list", org_unit: ou2)}
  let(:list3) { FactoryBot.create(:list, name: "Caro's private list", user: mcaro)}

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
  )}
  let!(:tl2) { FactoryBot.create(:task, :open, 
    subject: "ACME global list task",
    list: list1,
    start: "2020-07-17",
    deadline: "2020-12-24",
  )}
  let!(:done1) { FactoryBot.create(:task, :done,
    subject: "Task1 done!",
    responsible: mmax,
  )}
  let!(:archiv2) { FactoryBot.create(:task, :archive,
    subject: "Task2 done!",
    responsible: mcaro,
  )}
end
