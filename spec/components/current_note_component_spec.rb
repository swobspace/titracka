# frozen_string_literal: true

require "rails_helper"

RSpec.describe CurrentNoteComponent, type: :component do
  let(:task) { FactoryBot.create(:task) }
  describe "without a note" do
    it "renders nothing" do
      render_inline(described_class.new(notable: task))
      expect(rendered_content).to be_empty
    end
  end

  describe "with note" do
    let!(:note) { FactoryBot.create(:note, task_id: task.id, date: '2024-12-12',
                                     description: "Some notable text") }
    it "renders note with date" do
      render_inline(described_class.new(notable: task))
      expect(rendered_content).to match('2024-12-12')
      expect(rendered_content).to match('Some notable text')
    end
  end
end
