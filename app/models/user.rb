class User < ActiveRecord::Base
  TAGS =  ['Ruby', 'Java', 'HTML', 'CSS', 'JS', 'Node.JS']

  store_accessor :dict_json,   :department_json,   :location_json, :age_json
  store_accessor :dict_hstore, :department_hstore, :location_hstore, :age_hstore

  validates_presence_of :name

  before_update do
    self.tags = (self.tags || []).reject(&:blank?)
  end

  def name_of_some_hstore_key
    return (super == "true") if %w{true false}.include? super
    super
  end

  def self.to_ui
    select(:name).to_a
  end
end
