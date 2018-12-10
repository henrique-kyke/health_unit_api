require 'rails_helper'

RSpec.describe Api::VersionOne::HealthUnitsController, type: :controller do
  before(:all) do
    UbsImporter.new.perform
  end

  describe 'GET #find_ubs' do
    before do
      get :find_ubs, params: {query: "-23.551224,-46.634308", page: 1, per_page: 20 }
    end
    context 'with all params' do
      it 'should be successfull' do
        expect(response).to be_successful
      end
    end

  end
end
