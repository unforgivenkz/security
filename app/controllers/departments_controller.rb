class DepartmentsController < ApplicationController
  before_action :admin_user,     only: [:edit, :update, :destroy, :create]


  def new
      @department = Department.new
  end

  def create
  	@department = Department.new (dep_params)
        if @department.save
          redirect_to '/structure'
  	   else
  		    render 'new'
  	   end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(dep_params)
      flash[:success] = "Данные успешно изменены."
      redirect_to '/structure'
    else  
      render 'edit'
    end
  end

  def destroy
    Department.find(params[:id]).destroy
    flash[:success] = "Работник удален."
    redirect_to '/structure'
  end



  private

  def dep_params
    params.require(:department).permit(:name1, :name2, :name3, :tel, :post, :dep)
  end


  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end



          