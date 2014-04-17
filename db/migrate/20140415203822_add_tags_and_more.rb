class AddTagsAndMore < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION hstore'
    change_table :users do |t|
      t.string :tags, array: true, default: []
      t.hstore :dict_hstore
      t.json :dict_json
    end
  end
end
