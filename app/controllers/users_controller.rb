class UsersController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
  
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = 'Your account was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 10)
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  
end
