class Log < ActiveRecord::Base

  scope :ordered, -> {order("id desc")}

end
