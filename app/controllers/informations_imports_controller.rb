class InformationsImportsController < ApplicationController
  def new
 @informations_import = InformationsImport.new
  end

  def create
  @informations_import = InformationsImport.new(params[:informations_import])
    if @informations_import.save
      redirect_to users_path
    else
      render :new
    end
  end
end
