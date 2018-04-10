class Subscriber < ApplicationRecord
  validates :f_name, :l_name, :emall, :country,
            presence: true
end
