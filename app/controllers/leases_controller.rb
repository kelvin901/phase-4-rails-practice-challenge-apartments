class LeasesController < ApplicationController
    before_action :find_lease, only: %i[ destroy ]
    before_action :set_form_variables, only: %i[ new ]

    def new
        @lease = Lease.new
        @rent = @lease.rent
    end

    def create
        @lease = Lease.new(lease_params)
        respond_to do |format|
            if @lease.save
                format.html { redirect_to root_path, notice: "lease #{@lease.id} successfully created."}
                format.json { render 'show', status: :created, location: @lease}
            else
                set_form_variables
                format.html { render :new, status: :unprocessable_entity }
                format.json  {render json: @lease.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy 
        @lease.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "lease #{@lease.id} was successfully removed from the database." }
            format.json { head :no_content }
        end
    end

    private

    def find_lease
        @lease = Lease.find(params[:id])
    end

    def lease_params
        params.require(:lease).permit(
            :rent,
            :tenant_id, 
            :apartment_id,
            tenants_attributes: [:name, :age]
        )
    end

    def set_form_variables
        # Get all the apartments 
        @apartments = Apartment.all
        # Get all the tenants 
        @tenants = Tenant.all
    end
end