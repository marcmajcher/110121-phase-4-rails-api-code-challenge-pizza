class RestaurantPizzasController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_res
    
    def create
        restaurant_pizza = RestaurantPizza.create!(rp_param)
        render json: restaurant_pizza.pizza, status: :created
    end

    private

    def rp_param
        params.permit(:price, :pizza_id, :restaurant_id)
    end

    def invalid_record_res (invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
