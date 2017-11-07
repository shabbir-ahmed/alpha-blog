class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
  
    respond_to do |format|
      if @user.save
        flash[:success] = 'Welcome to the 3S blog'
        format.html { redirect_to articles_path }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  
end
