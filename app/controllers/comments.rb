class Comments < Application
  provides :xml, :js, :yaml
  
  before :article
  
  def create
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.new(params[:comment].merge(:article => @article))
    @comment.author = @comment.mods_up = viewer_data
    if @comment.save 
      redirect "/articles/#{@article.to_param}"
    else
      render :template => "articles/show.html"
    end
  end
  
  def update
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.mod(params[:mod], viewer_data)
    @saved = @comment.save
    if content_type == :html
      redirect "/articles/#{@article.to_param}"
    else
      render
    end
  end

end