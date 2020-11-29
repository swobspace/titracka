require 'rails_helper'

describe TaskConcerns do
  let(:task_open) {FactoryBot.create(:task, :open) }
  let(:task_archived) {FactoryBot.create(:task, :archive) }

  describe "#not_archived" do
    it "returns only active tasks" do
      tasks = [ task_open, task_archived ]
      expect(Task.not_archived).to contain_exactly(task_open)
    end
  end
end
