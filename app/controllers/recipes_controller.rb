class RecipesController < ApplicationController
    def index
        @recipe = Recipe.all
        render :json => {
            :recipes => @recipe
        }
    end

    def show
        id = params[:id] ? params[:id] : 1
        if Recipe.exists?(id: id)
            @recipe = Recipe.find(id)
            render :json => {
                :message  => "Recipe details by id",
                :recipes => [@recipe]
            }
        else
            render :json => {  :message => "No Recipe found" }
        end
    end

    def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save && params_check
            render :json => {
                :message => "Recipe successfully created!", 
                :recipe => [@recipe]
            }
        else
            render :json => {
                :message => "Recipe creation failed!", 
                :required => "title, making_time, serves, ingredients, cost"
            }
        end
    end

    def update
        id = params[:id] ? params[:id] : 1
        if Recipe.exists?(id: id) && params_check
            @recipe = Recipe.find(params[:id])
            if @recipe.update(recipe_params)
                res = {title: @recipe.title, making_time: @recipe.making_time, serves: @recipe.serves,ingredients: @recipe.ingredients,cost: @recipe.cost }
                render :json => {
                    :message => "Recipe successfully updated!", 
                    :recipe => [res]
                }
              else
                render json: @recipe.errors, status: :unprocessable_entity
            end
        else
            render :json => {  :message => "No Recipe found" }
        end
    end

    def destroy
        id = params[:id] ? params[:id] : 1
        if Recipe.exists?(id: id)
            @recipe = Recipe.find(params[:id])
            if @recipe.destroy
                render :json => {  :message => "Recipe successfully removed!" }
            else
                render :json => {  :message => "Recipe deletion failed!" }
            end
        else
            render :json => {  :message => "No Recipe found" }
        end
    end

    private
        def params_check
            if params["title"] && params["making_time"] && params["serves"] && params["ingredients"] && params["cost"]
                return true
            else
                return false
            end
        end
        def recipe_params
            params.require(:recipe).permit(:id,:title,:making_time,:serves,:ingredients,:cost)
        end
end

# mysql2://b903196f2fec67:cd3122e6@us-cdbr-east-04.cleardb.com/heroku_2a14cbcb596ca69?reconnect=true
# heroku config:add DB_NAME='heroku_2a14cbcb596ca69'
# heroku config:add DB_USERNAME='b903196f2fec67'
# heroku config:add DB_PASSWORD='cd3122e6'
# heroku config:add DB_HOSTNAME='us-cdbr-east-04.cleardb.com'
# heroku config:add DB_PORT='3306'