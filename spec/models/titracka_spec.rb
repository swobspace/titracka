require 'rails_helper'
  
RSpec.describe Titracka, type: :model do
  context" with empty Settings" do
    before(:each) do
      allow(Titracka::CONFIG).to receive(:[]).with('devise_modules').and_return(nil)
      allow(Titracka::CONFIG).to receive(:[]).with('mail_from').and_return(nil)
      allow(Titracka::CONFIG).to receive(:[]).with('use_ssl').and_return(nil)
      allow(Titracka::CONFIG).to receive(:[]).with('remote_user').and_return(nil)
      allow(Titracka::CONFIG).to receive(:[]).with('action_cable_allowed_request_origins').and_return(nil)
    end
    it { expect(Titracka.devise_modules).to contain_exactly(
                                           :remote_user_authenticatable,
                                           :database_authenticatable,
                                           :registerable,
                                           :recoverable,
                                           :rememberable,
                                           :trackable
                                         )}
    it { expect(Titracka.mail_from).to eq('root') }
    it { expect(Titracka.use_ssl).to be_falsey }
    it { expect(Titracka.remote_user).to eq('REMOTE_USER') }
    it { expect(Titracka.action_cable_allowed_request_origins).to contain_exactly(
         'http://localhost', 'https://localhost' ) }
  end

  describe "::ldap_options" do
    context" with empty Settings" do
      before(:each) do
        allow(Titracka::CONFIG).to receive(:[]).with('ldap_options').and_return(nil)
      end
      it { expect(Titracka.ldap_options).to be_nil}
    end

    context" with existing Settings" do
      let(:ldap_options) {{
        "host"=>"192.0.2.71",
        "port"=>3268,
        "base"=>"dc=example,dc=com",
        "auth"=>{
           "method"=>:simple,
           "username"=>"myldapuser",
           "password"=>"myldappasswd"
        }
      }}
      let(:ldap_options_ary) {[{
        "host"=>"192.0.2.71",
        "port"=>3268,
        "base"=>"dc=example,dc=com",
        "auth"=>{
           "method"=>:simple,
           "username"=>"myldapuser",
           "password"=>"myldappasswd"
        }
      }]}
      let(:ldap_options_sym) {[{
        host: "192.0.2.71",
        port: 3268,
        base: "dc=example,dc=com",
        auth: {
           method: :simple,
           username: "myldapuser",
           password: "myldappasswd"
        }
      }]}
      it "returns symbolized keys from Hash" do
        allow(Titracka::CONFIG).to receive(:[]).with('ldap_options').
          and_return(ldap_options)
        expect(Titracka.ldap_options).to eq(ldap_options_sym)
      end
      it "returns symbolized keys from Array of Hashes" do
        allow(Titracka::CONFIG).to receive(:[]).with('ldap_options').
          and_return(ldap_options_ary)
        expect(Titracka.ldap_options).to eq(ldap_options_sym)
      end
    end
  end
end
