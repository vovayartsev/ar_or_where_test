class User < ActiveRecord::Base
  scope :johnes, where(:first_name => "John")
  scope :smiths, where(:last_name => "Smith")
end
