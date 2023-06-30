class ApartmentsController < ApplicationController
    before_action :find_apartment, only: %i[show edit update destroy ]

    def index
        @apartments = Apartment.all
        @occupied_apartments = @apartments.not_vacant
        @vacant_apartments = @apartments.vacant
    end

   

    def show
        if @apartment.tenants.count > 0 
            @tenants = get_tenants
            @vacancy = false
        else 
            @vacancy = true 
        end
        @lease = Lease.where(apartment_id: @apartment.id)
    end
    
    def new
        @apartment = Apartment.new
    end

    def create
        @apartment = Apartment.new(apartment_params)
        respond_to do |format|
            if @apartment.save
                format.html { redirect_to @apartment, notice: "Apartment #{@apartment.number} successfully created."}
                format.json { render 'show', status: :created, location: @apartment}
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json  {render json: @listing.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @apartment.update(apartment_params)
                format.html { redirect_to @apartment, notice: "Apartment #{@apartment.number} successfully updated."}
                format.json { render 'show', status: :ok, location: @apartment}
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json  {render json: @listing.errors, status: :unprocessable_entity }
            end
        end

    end

    def destroy 
        @apartment.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Apartment #{@apartment.number} was successfully removed from the database." }
            format.json { head :no_content }
        end
    end

    private

    def get_tenants
        tenants = []
        t = 0 
        @apartment.tenants.each do |tenant| 
            tenants << {
                name: @apartment.tenants[t].name,
                age: @apartment.tenants[t].age
            }
            t += 1
        end 
        return tenants
    end

    def find_apartment
        @apartment = Apartment.find(params[:id])
    end

    def apartment_params
        params.require(:apartment).permit(
            :number,
        )
    end
end