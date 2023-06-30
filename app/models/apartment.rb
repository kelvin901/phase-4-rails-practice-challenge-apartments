class Apartment < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :tenants, through: :leases 
    
    # Ensure there is a number & it is an integer
    validates :number,
    presence: true,
    numericality: {only_integer: true} 
    accepts_nested_attributes_for :leases

    # Order the apartments by number
    default_scope { order('number') }

    # Return an apartment object for all apartments with leases.
    scope :not_vacant, -> {Apartment.joins(:leases)}

    # Return an apartment object for all apartments without leases.
    # scope :vacant, -> {Apartment.joins('LEFT OUTER JOIN leases ON (apartments.id = leases.apartment_id)').where('leases.apartment_id IS NULL')}
    scope :vacant, -> {Apartment.joins("LEFT OUTER JOIN leases ON apartments.id = leases.apartment_id").where(:leases => {:id => nil})}

end