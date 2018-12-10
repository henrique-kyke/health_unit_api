namespace :ubs do
  desc "Import UBS from csv to database"
  task import: :environment do
    UbsImporter.new.perform
  end
end
