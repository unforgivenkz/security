class KnowbasesController < ApplicationController
  include KnowbasesHelper
  before_action :admin_user,     only: [:edit, :update, :destroy, :create]


  def new
      @knowbase = Knowbase.new
  end

  def create
  	@knowbase = Knowbase.new (dep_params)
        if @knowbase.save
          redirect_to '/help'
  	   else
  		    render 'new'
  	   end
  end

  def edit
    @knowbase = Knowbase.find(params[:id])
  end

  def update
    @knowbase = Knowbase.find(params[:id])
    if @knowbase.update_attributes(dep_params)
      flash[:success] = "Данные успешно изменены."
      redirect_to '/help'
    else  
      render 'edit'
    end
  end

  def destroy
    Knowbase.find(params[:id]).destroy
    flash[:success] = "Объект удален."
    redirect_to '/help'
  end

  def show
    @knowbase = Knowbase.find(params[:id])
  end

  private

  def dep_params
    params.require(:knowbase).permit(:name, :keyword, :avatar, :doc)
  end


  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end



          