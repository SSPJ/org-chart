import React, { Component } from 'react'

export default class EmployeeDisplayContainer extends Component {
  render() {
    console.log("Rendering main employee display. . .");
    const hasSuperior = (this.props.employeeCard.superior !==  undefined)
    return (
      <div className="employeemain">
      {hasSuperior &&
        <div className="employeemain_tile-superior" key={this.props.employeeCard.superior.id}>
          <h4>{this.props.employeeCard.superior.position}</h4>
          <p>{this.props.employeeCard.superior.name}</p>
        </div>
      }
      <div className="employeemain_tile-person" key={this.props.employeeCard.id}>
        <h4>{this.props.employeeCard.position}</h4>
        <p>{this.props.employeeCard.name}</p>
      </div>
      </div>
    )
  }
}
