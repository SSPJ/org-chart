### Purpose

Display name, title, and position of people in an organization, arranged hierarchically. Provide an API for adding, updating, and removing people.

### Dependencies

* Ruby 2.4.0
* Rails 5.1.5
* Other dependencies as specified in package.json and Gemfile

Other versions of these may work but have not been tested.

### Installation
```
git clone https://github.com/SSPJ/org-chart.git
cd org-chart/orgchart-api/
bundle install --path vendor/bundle
rails db:schema:load
rails db:seed
cd ../orgchart/
yarn add serve # only if npm module serve is not already installed
```

### Usage

**In browser**
```
cd org-chart/orgchart-api/
rails s --port 3001 &
cd ../orgchart/
node_modules/serve/bin/serve.js -s build &
```
Open http://localhost:5000/ in a browser.

Use `fg` followed by <kbd>Ctrl</kbd> + <kbd>C</kbd> to shut down the servers.

**Via curl**
Set up the servers as described above, then
```
# Get all employees
curl -G http://localhost:3001/api/v1/employees
# Get a specific employee
curl -v -G 'http://localhost:3001/api/v1/employees/2'
# Get a specific employee and all subordinates
curl -v -G 'http://localhost:3001/api/v1/employees/2?all'
# Create an employee
curl -v -X POST -d "first_name=Susan&last_name=Edwards&title=Airplane%20Mechanic&manager_id=5" http://localhost:3001/api/v1/employees
# Update an employee
curl -v -X PUT -d "first_name=Susan&last_name=Edwards&title=Airplane%20Mechanic&manager_id=5" http://localhost:3001/api/v1/employees/7
# Delete an employee
curl -v -X DELETE http://localhost:3001/api/v1/employees/7
```

**Run tests**
```
cd org-chart/orgchart-api/
RAILS_ENV=test rails db:migrate
RAILS_ENV=test rails db:seed
bundle exec rspec
```

**Code ©2018, Seamus Johnston, all rights reserved except as required by upstream licenses**
