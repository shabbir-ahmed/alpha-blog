class ArticlesController < ApplicationController
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 10).order(id: :desc)
    
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @articles }
        end
    end
    
    def new
        @article = Article.new
    end
    
    def create
       # debugger
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def update
        @article = Article.find(params[:id])
        respond_to do |format|
            if @article.update_attributes(article_params)
                flash[:success] = 'Article was successfully updated.'
                format.html { redirect_to(@article) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:danger] = 'Article was successfully delete.'
    
        respond_to do |format|
            format.html { redirect_to(articles_url) }
            format.xml  { head :ok }
        end
    end
    
    private
    
    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end
    
    def require_same_user
        if !current_user.admin?
            flash[:danger] = "You can only delete your own article"
            redirect_to root_path
        end
        
    end
end