class FoldersController < ApplicationController
  def root
    render json: Folder.root
  end

  def childers
    render json: Folder.find(params[:id]).folders
  end

  def create
    folder = Folder.create(folder_params)

    if folder.save
      render json: folder, status: :created
    else
      render json: folder.errors, status: :unprocessable_entity
    end
  end

  def update
    folder = Folder.find(params[:id])

    if folder.update(folder_params)
      render json: folder, status: :created
    else
      render json: folder.errors, status: :unprocessable_entity
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:folder_id, :label)
  end
end
