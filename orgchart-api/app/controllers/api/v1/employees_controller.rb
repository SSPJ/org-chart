module Api::V1
  class EmployeesController < ApplicationController
    def index
      @emp = {id:1, name: "Dade Murphy","title":"CEO",direct_reports: [{id:2,name:"Kate Libby",position:"CTO",direct_reports: []},{id:3,name:"Edward Vedder",position:"CFO",direct_reports: []},{id:4,name:"Margo",position:"VP of Public Relations",direct_reports: []}]}
      logger.debug @emp.inspect
      logger.debug @emp.to_json
      logger.fatal "testing"
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
