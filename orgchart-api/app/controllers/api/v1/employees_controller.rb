module Api::V1
  class EmployeesController < ApplicationController
    def index
      @emp = [{id:1, name: "Dade\u00a0Murphy","position":"CEO",direct_reports: [{id:2,name:"Kate\u00a0Libby",position:"CTO",direct_reports: []},{id:3,name:"Edward\u00a0Vedder",position:"CFO",direct_reports: []},{id:4,name:"Margo",position:"VP\u00a0of\u00a0Public\u00a0Relations",direct_reports: []}]}]
      #@emp = Employee.all
      render json: @emp, formats: :json
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      @employee = Employee.create(employee_params)
      render json: @employee
    end

    def update
      @employee = Employee.find(params[:id])
      @employee.update_attributes(employee_params)
      render json: @employee
    end

    def destroy
      @employee = Employee.find(params[:id])
      if @employee.destroy
        head :no_content, status: :ok
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end

    private
      def employee_params
        params.require(:title,:first_name,:last_name).permit(:id,:manager_id)
      end
  end
end
