require 'rails_helper'

RSpec.describe Api::VersionOne::HealthUnitsController, type: :controller do
  before(:all) do
    UbsImporter.new.perform
  end

  describe 'GET #find_ubs' do
    context 'with all params' do
      before do
        get :find_ubs, params: {query: "-23.551224,-46.634308", page: 2, per_page: 5 }
      end

      it 'should be successfull' do
        expect(response).to be_successful
      end

      it 'should contains current_page and per_page info' do
        body = JSON.parse(response.boby)
        expect(body).to have_key('current_page')
        expect(body['current_page'].to_i).to eq 2
        expect(body).to have_key('per_page')
        expect(body['per_page'].to_i).to eq 5
      end

      it 'should contains total_entries' do
        body = JSON.parse(response.boby)
        expect(body).to have_key('total_entries')
      end

      it 'should contains entries' do
        body = JSON.parse(response.boby)
        expect(body).to have_key('entries')
        expect(body['entries']).to be_an_instance_of(Array)
      end

    context 'without page params' do
      before do
        get :find_ubs, params: {query: "-23.551224,-46.634308"}
      end

      it 'should be successfull' do
        expect(response).to be_successful
      end

      it 'should contains current_page and per_page info' do
        body = JSON.parse(response.boby)
        expect(body['current_page'].to_i).to eq 1
        expect(body['per_page'].to_i).to eq 10
      end
    end

    context 'without query param' do
      before do
        get :find_ubs
      end

      it 'should not be successfull' do
        expect(response).not_to be_successful
      end

      it 'should contains error' do
        body = JSON.parse(response.boby)
        expect(body).to has_key('error')
        expect(body['error']['field']).to eq 'query'
      end
    end

  end
end
