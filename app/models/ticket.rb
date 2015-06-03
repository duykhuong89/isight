class Ticket < ActiveRecord::Base
    has_many :ticket_categories, :dependent => :destroy
    has_many :categories, :through => :ticket_categories
    
    validates :title, :presence => true, :length => { :maximum => 120 }
end
