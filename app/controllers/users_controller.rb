class UsersController < ApplicationController
    # before_action :password_params, only: [ :update_password]

    before_action :find_user, only: [:edit_password, :update_password]


    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )

        if @user.save
            session[:user_id] = @user.id

            flash.notice = "Signed Up!"
            redirect_to root_path
        else
            render :new, status: 303
        end
    end
    


#===================UPDATE==========================
    def edit
       

    end

    def update
        @user = current_user
    
        # p '******* update ********'


        if @user.update(user_params)
            
            # p '******* if update ********'

            flash[:success] = "User info successfully updated"
            redirect_to posts_path
          
        else
            # p '******* else update ********'

            flash[:error] = "Something went wrong"
            render :edit
        end
    end

    def edit_password
       
    end

   
    def update_password
       
        if @user.authenticate(params[:user][:current_password])
            @user.update(
              password: params[:user][:new_password],
              password_confirmation: params[:user][:new_password_confirmation]
            )
      
            if @user.valid?
              flash[:success] = "Password changed"
              redirect_to edit_user_path(@user)
            else
              flash[:alert] = @user.errors.full_messages.join(", ")
              redirect_to edit_password_user_path(@user)
            end
          else
            flash[:alert] = "Did you forget your password?"
            redirect_to edit_password_user_path(@user)
          end

        # if @user.update(user_params)

        #     flash[:success] = "User info successfully updated"
        #     redirect_to posts_path
          
        # else

        #     flash[:error] = "Something went wrong"
        #     render :edit
        # end
    end





    private 
    def user_params   
        params.require(:user).permit(:first_name, :last_name, :email, :password )
    end


    def find_user
        @user = User.find params[:id]
        
    end

  

end
      










