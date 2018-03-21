import React, { Component } from 'react';
import './App.css';
import EmployeeListContainer from './components/EmployeeListContainer'
import EmployeeDisplayContainer from './components/EmployeeDisplayContainer'

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      displayEmployee: false,
    };
  }
  updateDisplayContainer = (childProps) => {
    // childProps is obtained from EmployeeListEntry
    this.setState({employeeCard: childProps, displayEmployee: true})
  }

  renderEmployeeDetail() {
    if (this.state.displayEmployee) {
      return(
        <EmployeeDisplayContainer employeeCard={this.state.employeeCard} />
      )
    }
    return (
    <div className="employeemain">Click any name to see its place in the chart.</div>
    )
  }

  // EmployeeListContainer displays on the left with employees as nested list items
  // EmployeeDisplayContainer displays on the right with the employee selected
  render() {
    return (
      <div className="App">
        <EmployeeListContainer updateDisplayContainer={this.updateDisplayContainer}/>
        { this.renderEmployeeDetail() }
      </div>
    );
  }
}

export default App;
