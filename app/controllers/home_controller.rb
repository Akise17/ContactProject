class HomeController < ApplicationController

    def user_param
        params.permit(:data=>[:name,:phone],
            :data2=>[:name,:phone],
            :home=>[:data=>[:name,:phone],:data2=>[:name,:phone]])
            #permit untuk struktur jsonnya
    end

    def index
        @user = User.all
        
        render json:{
            values: @user,
            message: "Success",
        }, status: 200
    end
    
    def show
        @user = User.find_by_id(params[:id])
        if @user.present?
            render json:{
                values: @user,
                message: "Success!",
            },status: 200
        else
            render json:{
                values: "",
                message: "We can't found any data",
            },status: 400
        end
    end  
    
    def create
        # @data = User.all
        @user = User.new(user_param[:data])
        if @user.save
            render json:{
                values: @user,
                message: "Success!",
            },status: 201
        else
            render json:{
                values: @data,
                message: "Failed",
            },status: 400
        end
    end

    def update
        @user = Object.find(params[:id])
        if @user.update_attributes(params[:user])
            render json:{
                values: {},
                message: "Success!",
            },status: 201
            flash[:success] = "Object was successfully updated"
        #   redirect_to @user
        else
            render json:{
                values: {},
                message: "Failed!",
            },status: 400
            flash[:error] = "Something went wrong"
        #   render 'edit'
        end
    end
    
    def destroy
        @user = Object.find(params[:id])
        if @user.destroy
            render json:{
                values: {},
                message: "Success!",
            },status: 201
            flash[:success] = 'Object was successfully deleted.'
            # redirect_to users_url
        else
            render json:{
                values: {},
                message: "Failed!",
            },status: 400
            flash[:error] = 'Something went wrong'
            redirect_to users_url
        end
    end
    
    
    def notFound
        render json:{
            values: {},
            message: "Data not Found!",
        },status: 404
    end 
end
