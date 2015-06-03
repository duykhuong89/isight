class TicketCategory < ActiveRecord::Base
    belongs_to :ticket
    belongs_to :category
    
    validates :ticket_id, :presence => true
    validates :category_id, :presence => true
    validates :category_id, :uniqueness => {:scope => :ticket_id}
end
