require 'rails_helper'

RSpec.describe 'Employees API', type: :request do
  # initialize test data 
  let!(:employees) { create_list(:employee, 10) }
  let(:employee_id) { employees.first.id }

  # Test suite for GET /api/v1/employees
  describe 'GET /api/v1/employees' do
    # make HTTP get request before each example
    before { get '/api/v1/employees' }

    it 'returns employees' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/employees/:id
  describe 'GET /api/v1/employees/:id' do
    before { get "/api/v1/employees/#{employee_id}" }

    context 'when the record exists' do
      it 'returns the employee' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(employee_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:employee_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /api/v1/employees
  describe 'POST /api/v1/employees' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/api/v1/employees', params: valid_attributes }

      it 'creates a employee' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/employees', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/employees/:id
  describe 'PUT /api/v1/employees/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/api/v1/employees/#{employee_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/employees/:id
  describe 'DELETE /api/v1/employees/:id' do
    before { delete "/api/v1/employees/#{employee_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
