class DocumentsController < AdminController

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end
  
  def create
    document = Document.new(params[:document])
    if document.save
  		redirect_to documents_path, :notice => "Successfully created document"
    else
      raise document.errors.inspect
      flash[:error] = "There was an error creating the document"
      redirect_to documents_path
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    document = Document.find(params[:id])
    if document.update_attributes(params[:document])
  		redirect_to documents_path, :notice => "Successfully updated document"
    else
      flash[:error] = "There was an error updating the document"
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path
  end


end