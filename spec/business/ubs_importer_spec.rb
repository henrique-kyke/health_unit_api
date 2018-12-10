require 'rails_helper'

RSpec.describe UbsImporter do

  context 'setting up' do
    let(:importer) { described_class.new }

    it 'should starts with schema' do
      expect(importer.schema).to be_present
      expect(importer.data).to be_an_instance_of(Array)
      expect(importer.data).to be_empty
    end
  end

  context 'performing' do
    before(:all) do
      @private_methods = described_class.private_instance_methods
      described_class.send(:public, *@private_methods)
      @importer = described_class.new
      @ubs = [{
        vlr_latitude: -23.551224,
        vlr_longitude: -46.634308,
        cod_munic: "1234",
        cod_cnes: "1234",
        nom_estab: "SÉ",
        dsc_endereco: "SÉ",
        dsc_bairro: "Sé",
        dsc_cidade: "São Paulo",
        dsc_telefone: "(11) 5555-5555",
        dsc_estrut_fisic_ambiencia: "Desempenho mediano ou  um pouco abaixo da média",
        dsc_adap_defic_fisic_idosos: "Desempenho acima da média",
        dsc_equipamentos: "Desempenho acima da média",
        dsc_medicamentos: "Desempenho muito acima da média"
      }]
    end

    it 'should load source data' do
      allow(UbsCsvReader.new).to receive(:read).and_return(@ubs)
      expect(@importer.load_data).to be_an_instance_of(Array)
      expect(@importer.data).not_to be_empty
    end

    it 'should persist a Health unit' do
      expect(@importer.import).not_to be_empty
    end
  end
end