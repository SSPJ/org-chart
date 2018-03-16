module Api::V1
  class EmployeesController < ApplicationController
    def index
      @employees = Employee.all
      render json: @employees
    end
  end
end
