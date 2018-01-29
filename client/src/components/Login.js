import React from 'react'
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom'
import * as actions from '../actions';
import { Segment, Form, Button } from 'semantic-ui-react'
import SignUp from './SignUp'



class Login extends React.Component{
  constructor(){
    super()
    this.state = {
      name: '',
      password: ''
    }
    this.handleNameChange = this.handleNameChange.bind(this)
    this.handlePasswordChange = this.handlePasswordChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleNameChange(name){
    this.setState({
      name: name
    })
  }

  handlePasswordChange(password){
    this.setState({
      password: password
    })
  }

  handleSubmit(e){
    e.preventDefault()
    this.props.loginUser(this.state, this.props.history)
  }

  render(){
    const titlePhoto  = 'https://static.pexels.com/photos/63324/california-road-highway-mountains-63324.jpeg'
    const inputStyle = { color: `white`,
                        background: `none`,
                        border: `none`,
                        fontSize:`“50px`,
                        width: `350px`,
                        height: `95px`,
                        borderBottom: `1px solid white`,
                        margin: '2%'}

    const font  ={   fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                      fontSize: '48px',
                      fontStyle: 'normal',
                      fontVariant: 'normal',
                      fontWeight: '500',
                      lineHeight: '26.4px',
                      color: 'white',
                      margin: '2%'}
    return(
      <Segment style = {{
          backgroundImage: `url(${titlePhoto})`,
          minHeight: "900px",
          backgroundSize: "cover",
          backgroundRepeat: "no-repeat",
          backgroundPosition: "0% 70%",
          margin: '0',
          textAlign: 'center',
          display: 'block',
        }} >
        <h1 style = {font}>ROADMAPS</h1>
        <Segment inverted>
        <Form inverted>
          <Form.Group widths='equal'>
            <Form.Input fluid label='First name' placeholder='First name' />
            <Form.Input fluid label='Last name' placeholder='Last name' />
          </Form.Group>
          <Form.Checkbox label='I agree to the Terms and Conditions' />
          <Button type='submit'>Submit</Button>
        </Form>
        </Segment>
          <Form onSubmit = {(e) => this.handleSubmit(e)}>

            <input
              fluid
              label='Username'
              placeholder='Username'
              onChange = {(e) => this.handleNameChange(e.target.value)}/>

            <input
              fluid
              type = "password"
              label='Password'
              placeholder='Password'
              onChange = {(e) => this.handlePasswordChange(e.target.value)}/>

            <br/>
            <Button type='submit'>Login</Button>
          </Form>
          <SignUp/>
      </Segment>

    )
  }
}



export default withRouter(connect(null, actions)(Login));
