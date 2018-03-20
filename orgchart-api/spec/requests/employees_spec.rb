require 'rails_helper'

RSpec.describe 'Employees API', type: :request do
  before(:all) do
    $example_employee_id = 5
    $example_employee_manager_id = 2
    $example_subordinate_id = 7
  end

  describe 'GET /api/v1/employees' do
    before { get "/api/v1/employees" }

    it 'returns employees' do
      json_parsed = JSON.parse(response.body)
      expect(json_parsed).not_to be_empty
      expect(json_parsed.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/employees/:id' do
    context 'when the employee exists' do
      before { get "/api/v1/employees/#{$example_employee_id}" }
      it 'returns the employee' do
        json_parsed = JSON.parse(response.body)
        expect(json_parsed).not_to be_empty
        expect(json_parsed['id']).to eq($example_employee_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the employee does not exist' do
      before { get "/api/v1/employees/700" }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when employee and subordinates are requested' do
      before { get "/api/v1/employees/#{$example_employee_id}?all" }
      it 'returns the employee with subordinates' do
        json_parsed = JSON.parse(response.body)
        expect(json_parsed[0]['direct_reports']).not_to be_empty
      end
    end
  end

  describe 'POST /api/v1/employees' do
    before do
      DatabaseCleaner.start
    end

    let(:new_employee) { { first_name: 'Susan', last_name: 'Edwards',
      title: 'Airplane Mechanic', manager_id: $example_employee_id } }
    let(:new_employee_no_manager_id) { { first_name: 'Susan', last_name: 'Edwards',
      title: 'Airplane Mechanic' } }
    let(:new_employee_no_last_name) { { first_name: 'Susan',
      title: 'Airplane Mechanic', manager_id: $example_employee_id } }

    context 'when the request is valid' do
      before { post '/api/v1/employees', params: new_employee }

      it 'creates an employee' do
        expect(JSON.parse(response.body)['title']).to eq('Airplane Mechanic')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the employee has no last name' do
      before { post '/api/v1/employees', params: new_employee_no_last_name }
    
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
    
    context 'when the employee has no manager id' do
      before { post '/api/v1/employees', params: new_employee_no_manager_id }
    
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    after do
      DatabaseCleaner.clean
    end
  end

  describe 'PUT /api/v1/employees/:id' do
    before do
      DatabaseCleaner.start
    end

    let(:updated_employee) { { first_name: 'Anthony', last_name: 'Box',
      manager_id: $example_employee_id } }

    context 'when the employee exists' do
      before { put "/api/v1/employees/#{$example_employee_id}", params: updated_employee }

      it 'updates the employee' do
        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body)['last_name']).to eq('Box')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the employee does not exist' do
      before { put "/api/v1/employees/700" }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    after do
      DatabaseCleaner.clean
    end
  end

  describe 'DELETE /api/v1/employees/:id' do
    before do
      DatabaseCleaner.start
      delete "/api/v1/employees/#{$example_employee_id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'should really delete' do
      get "/api/v1/employees/#{$example_employee_id}"
      expect(response).to have_http_status(404)
    end

    it 'reassigns subordinate employees' do
      get "/api/v1/employees/#{$example_subordinate_id}"
      expect(JSON.parse(response.body)['manager_id']).to eq($example_employee_manager_id)
    end

    after do
      DatabaseCleaner.clean
    end
  end
end
