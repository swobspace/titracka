require 'rails_helper'

describe TaskConcerns do
  fixtures :tasks
  let(:task_open) {FactoryBot.create(:task, :open) }
  let(:task_archived) {FactoryBot.create(:task, :archive) }
  let(:task1) { tasks(:task1) }
  let(:task2) { tasks(:task2) }

  describe "#visible" do
    it "returns only active tasks" do
      tasks = [ task_open, task_archived ]
      expect(Task.visible).to contain_exactly(task_open, task1, task2)
    end
  end
end
