class UsersController < ApplicationController
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
      end



      def edit
      end

      def update
        
        # @user = User.find params[:id]

        if @user.update(user_params)
          flash[:success] = "User info successfully updated"
          redirect_to @post
          
        else
          flash[:error] = "Something went wrong"
          render :edit
        end
      end   









