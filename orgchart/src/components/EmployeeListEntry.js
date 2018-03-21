import React, { Component } from 'react'
import PropTypes from 'prop-types';

// Displays a single employee in the employee <ul>
export default class EmployeeListEntry extends Component {
  render() {
    // onClick sends this employee's data to updateDisplayContainer() via EmployeeListContainer
    return (
      <li>
        <div className="employeenav_person"
          onClick={this.props.updateDisplayContainer.bind(this,this.props)}>
        { this.props.name }
        </div>
        { this.props.children }
      </li>
    )
  }
}

EmployeeListEntry.propTypes = {
  clickable: PropTypes.func,
};
