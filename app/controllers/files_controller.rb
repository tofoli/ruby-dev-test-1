class FilesController < ApplicationController
  def index
    folder = Folder.find(params[:folder_id]).files.map { |f| to_json(f) }

    render json: folder
  end

  def create
    folder = Folder.find(params[:folder_id])
    folder.files.attach(params[:file])

    render json: to_json(folder.files.last)
  end

  def destroy
    folder = Folder.find(params[:folder_id])
    folder.files.find(params[:id]).purge

    head 204
  end

  private

  def to_json(file)
    {
      id: file.id,
      filename: file.filename.to_s,
      url: url_for(file),
    }
  end
end
