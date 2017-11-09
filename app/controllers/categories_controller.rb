class CategoriesController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  def index
    @categories = Category.all
  
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @categoriess }
    end
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
  
    respond_to do |wants|
      if @category.save
        flash[:success] = 'Category was successfully created.'
        wants.html { redirect_to categories_path }
        wants.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show

  end

  def edit
    
  end
  
  def update
    respond_to do |wants|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        wants.html { redirect_to categories_path }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @category.destroy
  
    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_params
    @category = Category.find(params[:id])
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "only admin user can perform"
      redirect_to categories_path
    end
  end
end
