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
  handleClick = (childProps) => {
    console.log("we got clicked!")
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

  render() {
    return (
      <div className="App">
        <div className="employeenav">
          <h1>Testing stuff</h1>
          <EmployeeListContainer parentFunc={this.handleClick}/>
        </div>
        { this.renderEmployeeDetail() }
      </div>
    );
  }
}

export default App;
