import React, { Component } from 'react'
import PropTypes from 'prop-types';

export default class EmployeeListEntry extends Component {
  render() {
    console.log("Rendering item:");
    console.log(JSON.stringify(this.props.name));
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
