class PizzasController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    def index
        render json: Pizza.all, status: :ok
    end

    
    #Doing extra this is not include in the test LOL
    private 
    def record_not_found_response
        render json:{error: "Restaurant not found"}, status: :not_found
    end
end
