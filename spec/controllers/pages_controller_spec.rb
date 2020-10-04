require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  ['about'].each do |page|
    describe "GET /pages/#{page}" do
      it "returns a success response" do
        get :show,  params: {page: "#{page}"} 
        expect(response).to be_successful
      end
    end
  end


end
