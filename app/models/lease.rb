class Lease < ApplicationRecord
    belongs_to :apartment
    belongs_to :tenant
    validates :rent, presence: true, numericality: {only_integer: true}
    validates :apartment_id, presence: true
  
    accepts_nested_attributes_for :tenant
    validates_associated :tenant
  
    
  
    after_initialize :set_defaults
  
  def set_defaults
    self.rent = Faker::Number.between(from: 1000, to: 3000)
  end
  
    # has_many :available_apartments, through: :leases, source: :leases
  
  
    # Inner join where there are vacancies on the apartment table. (where )
    # scope :available, -> {Lease.where)}
  
  
  end