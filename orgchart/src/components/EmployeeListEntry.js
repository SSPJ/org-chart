import React, { Component } from 'react'
import PropTypes from 'prop-types';

export default class EmployeeListEntry extends Component {
  render() {
    console.log("Rendering item:");
    console.log(JSON.stringify(this.props.name));
    return (
      <li>
        <div className="employeenav_person"
          onClick={this.props.clickable.bind(this,this.props)}>
        <b>{ this.props.position }</b>&nbsp;-&nbsp;{ this.props.name }
        </div>
        { this.props.children }
      </li>
    )
  }
}

EmployeeListEntry.propTypes = {
  clickable: PropTypes.func,
};
