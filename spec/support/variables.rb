RSpec.shared_context "basic variables" do
  let(:myuser) { FactoryBot.create(:user) }
  let(:anybody) { FactoryBot.create(:user) }
  let!(:ou_0) { FactoryBot.create(:org_unit) }
  let!(:ou_1) { FactoryBot.create(:org_unit, parent: ou_0) }
  let!(:ou_2) { FactoryBot.create(:org_unit, parent: ou_1) }
  let!(:ou_x0) { FactoryBot.create(:org_unit) }
  let!(:ou_x1) { FactoryBot.create(:org_unit, parent: ou_x0) }
  let!(:ou_x2) { FactoryBot.create(:org_unit, parent: ou_x1) }

  let(:list_0) { FactoryBot.create(:list, name: "L0", org_unit: ou_0) }
  let(:list_1) { FactoryBot.create(:list, name: "L1", org_unit: ou_1) }
  let(:list_2) { FactoryBot.create(:list, name: "L2", org_unit: ou_2) }
  let(:list_u0) { FactoryBot.create(:list, name: "LU0", org_unit: ou_0, user_id: myuser.id)}
  let(:list_u1) { FactoryBot.create(:list, name: "LU1", org_unit: ou_1, user_id: myuser.id)}
  let(:list_u2) { FactoryBot.create(:list, name: "LU2", org_unit: ou_2, user_id: myuser.id)}
  let(:list_x0) { FactoryBot.create(:list, name: "LX0", org_unit: ou_x0, user_id: anybody.id)}
  let(:list_x1) { FactoryBot.create(:list, name: "LX1", org_unit: ou_x1, user_id: anybody.id)}
  let(:list_x2) { FactoryBot.create(:list, name: "LX2", org_unit: ou_x2, user_id: anybody.id)}
  let(:list_xu0) { FactoryBot.create(:list, name: "LXU0", org_unit: ou_x0, user_id: myuser.id)}
  let(:list_xu1) { FactoryBot.create(:list, name: "LXU1", org_unit: ou_x1, user_id: myuser.id)}
  let(:list_xu2) { FactoryBot.create(:list, name: "LXU2", org_unit: ou_x2, user_id: myuser.id)}

  let(:task_o0) { FactoryBot.create(:task, subject: "TO0", org_unit: ou_0) }
  let(:task_o1) { FactoryBot.create(:task, subject: "TO1", org_unit: ou_1) }
  let(:task_o2) { FactoryBot.create(:task, subject: "U2", org_unit: ou_2) }
  let(:task_x0) { FactoryBot.create(:task, subject: "TX0", org_unit: ou_x0) }
  let(:task_x1) { FactoryBot.create(:task, subject: "TX1", org_unit: ou_x1) }
  let(:task_x2) { FactoryBot.create(:task, subject: "TX2", org_unit: ou_x2) }
  let(:task_u0) { FactoryBot.create(:task, subject: "TU0", org_unit: ou_x0, user_id: myuser.id) }
  let(:task_u1) { FactoryBot.create(:task, subject: "TU1", org_unit: ou_x1, user_id: myuser.id) }
  let(:task_u2) { FactoryBot.create(:task, subject: "TU2", org_unit: ou_x2, user_id: myuser.id) }
  let(:task_r0) { FactoryBot.create(:task, subject: "TU0", org_unit: ou_x0, responsible_id: myuser.id) }
  let(:task_r1) { FactoryBot.create(:task, subject: "TU1", org_unit: ou_x1, responsible_id: myuser.id) }
  let(:task_r2) { FactoryBot.create(:task, subject: "TU2", org_unit: ou_x2, responsible_id: myuser.id) }
  let(:task_pu0) { FactoryBot.create(:task, subject: "TU0", user_id: myuser.id, private: true) }
  let(:task_pr0) { FactoryBot.create(:task, subject: "TU0", responsible_id: myuser.id, private: true) }

  let(:tac_o0) { FactoryBot.create(:time_accounting, task: task_o0) }
  let(:tac_o1) { FactoryBot.create(:time_accounting, task: task_o1) }
  let(:tac_o2) { FactoryBot.create(:time_accounting, task: task_o2) }
  let(:tac_u0) { FactoryBot.create(:time_accounting, user_id: myuser.id)}
  let(:tac_xu0) { FactoryBot.create(:time_accounting, user_id: anybody.id)}

  let(:wday_u0) { FactoryBot.create(:workday, user_id: myuser.id) }
  let(:wday_xu0) { FactoryBot.create(:workday, user_id: anybody.id) }
end
