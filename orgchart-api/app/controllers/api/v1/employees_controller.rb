module Api::V1
  class EmployeesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound do |exception|
      head :not_found
    end

    ##
    # Returns a nested hash of employee organizational chart.
    def nestJSON(r)
      {
        id: r.id,
        name: r.first_name ? "#{r.first_name} #{r.last_name}" : r.last_name,
        position: r.title,
        direct_reports: r.underlings.empty? ? [] : r.underlings.map { |u| nestJSON(u) }
      }
    end

    def index
      @emp = [nestJSON(Employee.includes(:underlings).find_by manager_id: nil)]
      render json: @emp
    end

    def show
      if params.has_key? :all
        @emp = [nestJSON(Employee.includes(:underlings).find(params[:id]))]
      else
        @emp = Employee.find(params[:id])
      end
      render json: @emp
    end

    def create
      unless params.has_key? :manager_id and params.has_key? :last_name
        head :unprocessable_entity and return
      end
      @emp = Employee.create(employee_params)
      render json: @emp, status: :created
    end

    def update
      @emp = Employee.find(params[:id])
      @emp.update_attributes(employee_params)
      render json: @emp
    end

    def destroy
      @emp = Employee.find(params[:id])
      unless @emp.underlings.empty?
        if @emp.manager_id.nil?
          head :unprocessable_entity and return
        end
        @emp.underlings.each do |u|
          u.manager_id = @emp.manager_id
          u.save
        end
      end
      if @emp.destroy
        head :no_content, status: :ok
      else
        render json: @emp.errors, status: :unprocessable_entity
      end
    end

    private
      def employee_params
        params.permit(:title,:first_name,:last_name,:manager_id)
      end
  end
end
