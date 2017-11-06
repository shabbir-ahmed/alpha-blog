class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all
    
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @articles }
        end
    end
    
    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
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
        params.require(:article).permit(:title, :description)
    end
end