require 'rails_helper'

module TimeAccountingsDatatableHelper
  def ta2array(ta)
    [].tap do |column|
      column << ta.date.to_s
      column << ta.duration
      column << ta.formatted_duration
      column << ta.task.subject
      column << ta.description
      column << ta.user.to_s
      column << "  " # dummy for action links
    end
  end

  def link_helper(text, url)
    text
  end

  def polymorphic_path(value)
    value.to_s
  end
end
 
RSpec.describe TimeAccountingsDatatable, type: :model do
  fixtures 'wobauth/users', :tasks, :time_accountings, :states
  let(:ta11) { time_accountings(:ta11) }
  let(:ta12) { time_accountings(:ta12) }
  let(:ta13) { time_accountings(:ta13) }
  let(:ta21) { time_accountings(:ta21) }
  let(:ta22) { time_accountings(:ta22) }
  include TimeAccountingsDatatableHelper

  let(:view_context) { double(ActionView::Base) }
  let(:timeaccountings)    { TimeAccounting.all }
  let(:datatable)    { TimeAccountingsDatatable.new(timeaccountings, view_context) }

  before(:each) do
    allow(view_context).to receive(:params).and_return(myparams)
    allow(view_context).to receive_messages(
      raw: "",
      edit_time_accounting_path: "",
      time_accounting_path: "",
      task_path: "",
      download_link: "",
      show_link: "",
      edit_link: "",
      delete_link: "",
    )
    allow(view_context).to receive(:link_to) do |text, url|
      link_helper(text, url)
    end
    allow(view_context).to receive(:polymorphic_path) do |arg|
      polymorphic_path(arg)
    end
  end

  describe "without search params, start:0, length:10" do
    let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
      columns: {"0"=> {search: {value: ""}}},
      order: {"0"=>{column: "1", dir: "asc"}},
      start: "0",
      length: "10",
      search: {value: "", regex: "false"}
    )}
    subject { datatable.to_json }
    it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
    it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
    it { expect(parse_json(subject, "recordsFiltered")).to eq(5) }
    it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta21)) }
    it { expect(parse_json(subject, "data/4")).to eq(ta2array(ta13)) }
  end 

  describe "without search params, start:2, length:2" do
    let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
      columns: {"0"=> {search: {value: ""}}},
      order: {"0"=>{column: "0", dir: "asc"}},
      start: "2",
      length: "2",
      search: {value: "", regex: "false"}
    )}
    subject { datatable.to_json }
    it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
    it { expect(parse_json(subject, "recordsFiltered")).to eq(5) }
    it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta11)) }
    it { expect(parse_json(subject, "data/1")).to eq(ta2array(ta13)) }
  end 

  describe "with search: special" do
    let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
      order: {"0"=>{column: "1", dir: "asc"}},
      start: "0",
      length: "10",
      "search"=> {"value"=>"special", regex: "false"}
    )}
    subject { datatable.to_json }
    it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
    it { expect(parse_json(subject, "recordsFiltered")).to eq(1) }
    it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta21)) }
  end 

  describe "with search params, start:0, length:10" do
    subject { datatable.to_json }

    context "column 0: date yesterday" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"0" => {search: {value: "#{1.day.before(Date.current)}", regex: "false"}}},
        order: {"0" => {"column" => "1", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(3) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta21)) }
      it { expect(parse_json(subject, "data/1")).to eq(ta2array(ta11)) }
      it { expect(parse_json(subject, "data/2")).to eq(ta2array(ta13)) }
    end

    context "column 1: duration: 45" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"1" => {search: {value: "45", regex: "false"}}},
        order: {"0" => {"column" => "0", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(1) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta12)) }
    end

    context "column 2: formatted_duration: 01:15" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"2" => {search: {value: "01:15", regex: "false"}}},
        order: {"0" => {"column" => "0", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(1) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta13)) }
    end

    context "column 3: task, max" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"3" => {search: {value: "max", regex: "false"}}},
        order: {"0" => {"column" => "1", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(3) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta11)) }
      it { expect(parse_json(subject, "data/1")).to eq(ta2array(ta12)) }
      it { expect(parse_json(subject, "data/2")).to eq(ta2array(ta13)) }
    end

    context "column 4: description: special" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"4" => {search: {value: "special", regex: "false"}}},
        order: {"0" => {"column" => "1", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(1) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta21)) }
    end

    context "column 5: user: max" do
      let(:myparams) {ActiveSupport::HashWithIndifferentAccess.new(
        columns: {"5" => {search: {value: "max", regex: "false"}}},
        order: {"0" => {"column" => "1", "dir" => "asc"}},
        start: "0", length: "10", search: {value: "", regex: "false"}
      )}
      it { expect(datatable).to be_a_kind_of TimeAccountingsDatatable }
      it { expect(parse_json(subject, "recordsTotal")).to eq(5) }
      it { expect(parse_json(subject, "recordsFiltered")).to eq(3) }
      it { expect(parse_json(subject, "data/0")).to eq(ta2array(ta11)) }
      it { expect(parse_json(subject, "data/1")).to eq(ta2array(ta12)) }
    end

  end
end
