require 'rails_helper'

describe User do
    describe 'validations' do
        it { should validate_uniqueness_of(:email) }
        it { should validate_presence_of(:password) }
        it { should validate_presence_of(:api_key) }
        it { should have_secure_password }
    end
end