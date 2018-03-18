import React, { Component } from 'react'
import PropTypes from 'prop-types';
import axios from 'axios'
import EmployeeListEntry from './EmployeeListEntry'

export default class EmployeeListContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      loading: true,
    };
  }
  componentDidMount() {
    axios.get("http://localhost:3001/api/v1/employees.json")
    .then(response => {
      console.log(response)
      this.setState({employees: response.data, loading: false})
    })
    .catch(error => console.log(error))
  }
  renderEmployeeList(employees,boss) {
    const renderUnderlings = (underlings,superior) => {
      if (underlings.length > 0) {
        return <ul>{ this.renderEmployeeList(underlings,superior) }</ul>
      }
    }
    return employees.map((person) => {
      console.log("In renderEmployeeList(employees) with:");
      console.log(JSON.stringify(person));
      console.log("and direct_reports of:");
      console.log(JSON.stringify(person.direct_reports));
      return <EmployeeListEntry key={ person.id }
        clickable={ this.props.parentFunc }
        position={ person.position }
        name={ person.name }
        superior={ boss }>
        { renderUnderlings(person.direct_reports,person) }
      </EmployeeListEntry>
    });
  }
  render() {
    if (this.state.loading) {
      return <div>Loading. . . </div>
    }
    console.log("Rendering main employee list. . .");
    return (
    <div>
      <ul>
      { this.renderEmployeeList(this.state.employees) }
      </ul>
    </div>
    )
  }
}

EmployeeListContainer.propTypes = {
  parentFunc: PropTypes.func,
};
