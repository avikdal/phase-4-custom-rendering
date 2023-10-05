class CheesesController < ApplicationController

  # GET /cheeses
  def index
    cheeses = Cheese.all
    render json: cheeses
  end

  # GET /cheeses/:id
  def show
    cheese = Cheese.find_by(id: params[:id])

    # render json: cheese

    # render json: {
    #   id: cheese.id,
    #   name: cheese.name,
    #   price: cheese.price,
    #   is_best_seller: cheese.is_best_seller
    # }

    # To simplify this process, we can take advantage of some built-in serialization options available to us in the render method. For example, we can use the only: option directly after listing an object or array of objects we want to render to JSON:

    # render json: cheeses, only: [:id, :name, :price, :is_best_seller]

    # Alternatively, rather than specifically listing every key we want to include, we could also exclude particular content using the except: option, like so:

    # render json: cheeses, except: [:created_at, :updated_at], methods: [:summary]
  
    # With that code in place, our JSON response contains an additional key-value pair, in which the key is the name of the method and the value is the result of calling the method for the current Cheese object: { "id": 1, "name": "Cheddar", "price": 3, "is_best_seller": true, "summary": "Cheddar: $3" }

    # The above code would achieve the same result, producing only id, name, price, and is_best_seller for each cheese. All the keys except created_at and updated_at.

    # Both the only and except options are available to us thanks to the .as_jsonLinks to an external site. method, which Rails uses internally when we call render json: with an Active Record object.

    if cheese
      render json: cheese, except: [:created_at, :updated_at], methods: [:summary]
    else
      # status: :not_found will produce a 404 status code
    render json: { error: 'Cheese not found' }, status: :not_found
    end

  end

end
