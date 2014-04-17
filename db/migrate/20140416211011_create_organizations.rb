class CreateOrganizations < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
    Organization.create :name => 'Google'
    Organization.create :name => 'Apple'
  end
end
