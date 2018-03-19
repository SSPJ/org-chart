import React, { Component } from 'react'
import PropTypes from 'prop-types';
import axios from 'axios'
import EmployeeListEntry from './EmployeeListEntry'

export default class EmployeeListContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      loading: true,
      queryString: undefined
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
      //console.log("In renderEmployeeList(employees) with:");
      //console.log(JSON.stringify(person));
      //console.log("and direct_reports of:");
      //console.log(JSON.stringify(person.direct_reports));
      var direct_reports_detail = [];
      if (person.direct_reports.length > 0) {
        for (var i = 0; i < person.direct_reports.length; i++) {
           direct_reports_detail.push({id: person.direct_reports[i].id,
                                       name: person.direct_reports[i].name,
                                       position: person.direct_reports[i].position});
        }
      }
      if (this.state.queryString) {
        var skip = person.name.toLowerCase().indexOf(this.state.queryString) == -1 &&
                   person.position.toLowerCase().indexOf(this.state.queryString) == -1;
      }
      console.log(JSON.stringify(direct_reports_detail))
      return ( skip ? (
          <li>{ renderUnderlings(person.direct_reports,person) }</li>
        ) : (
        <EmployeeListEntry key={ person.id }
          updateDisplayContainer={ this.props.updateDisplayContainer }
          position={ person.position }
          name={ person.name }
          superior={ boss }
          direct_reports={ direct_reports_detail }>
          { renderUnderlings(person.direct_reports,person) }
        </EmployeeListEntry>
      ))
    });
  }
  filterList = (e) => {
    this.setState({queryString: e.target.value})
  }
  render() {
    if (this.state.loading) {
      return <div>Loading. . . </div>
    }
    console.log("Rendering main employee list. . .");
    return (
    <section className="employeenav">
      <input type="search" placeholder="Search" onChange={this.filterList} />
      <ul>
      { this.renderEmployeeList(this.state.employees) }
      </ul>
    </section>
    )
  }
}

EmployeeListContainer.propTypes = {
  updateDisplayContainer: PropTypes.func,
};
