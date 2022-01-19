class RestaurantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
    # return all restaurants  
    # route: GET: /restaurants
    def index
        render json: Restaurant.all, status: :ok
    end

    #show individual resraunt .find(id) 
    #route: GET /restaurants/:id
    def show
        restaurant = find_restaurant
        render json: restaurant, status: :ok, serializer: AssociateRestaurantPizzaSerializer
    end

    #delete th restaurant and its associated record in join table
    def destroy
        restaurant = find_restaurant
        restaurant.restaurant_pizzas.destroy_all
        restaurant.destroy
        head :no_content
    end
    
    # Helper methods
    private 
    
    def find_restaurant
        Restaurant.find(params[:id])
    end

    def record_not_found_response
        render json:{error: "Restaurant not found"}, status: :not_found
    end



end
