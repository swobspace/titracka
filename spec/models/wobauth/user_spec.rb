require 'rails_helper'

RSpec.describe State, type: :model do
  fixtures 'wobauth/users'

  describe "#short_name" do
    it { expect(wobauth_users(:mmax).short_name).to eq("Mustermann, Max") }
  end
end

