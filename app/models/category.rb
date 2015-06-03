class Category < ActiveRecord::Base
    has_many :ticket_categories, :dependent => :destroy
end
