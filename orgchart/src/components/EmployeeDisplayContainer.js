import React, { Component } from 'react'

export default class EmployeeDisplayContainer extends Component {
  render() {
    console.log("Rendering main employee display. . .");
    const hasSuperior = (this.props.employeeCard.superior !==  undefined)
    const hasUnderlings = (this.props.employeeCard.direct_reports.length > 0)
    return (
      <section className="employeemain">
        {hasSuperior &&
          <div className="employeemain_tile-superior" key={this.props.employeeCard.superior.id}>
            <p><b>{this.props.employeeCard.superior.position}</b></p>
            <p>{this.props.employeeCard.superior.name}</p>
          </div>
        }
        <div className="employeemain_tile-person" key={this.props.employeeCard.id}>
          <p><b>{this.props.employeeCard.position}</b></p>
          <p>{this.props.employeeCard.name}</p>
        </div>
        {hasUnderlings &&
          this.props.employeeCard.direct_reports.map((report) => {
            return (
            <div className="employeemain_tile-underling" key={report.id}>
              <p>{report.name}</p>
              <p><b>{report.position}</b></p>
            </div>
            )
          })
        }
      </section>
    )
  }
}
