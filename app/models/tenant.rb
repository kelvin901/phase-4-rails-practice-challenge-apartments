class Tenant < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :apartments, through: :leases
    validates :age, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 18}
    validates :name, presence: true
    accepts_nested_attributes_for :leases
    default_scope {order(:name)}

    scope :homed, -> {Tenant.joins(:leases)}
    scope :homeless, -> {Tenant.joins("LEFT OUTER JOIN leases ON tenants.id = leases.tenant_id").where(:leases => {:id => nil})}
end