import React from 'react';
import { Link } from 'react-router-dom';
import logo from './logo.png';
import def from './def.png';
import './components.css';
import './templates';
import './creation_page';
export default function navbar() {
  return (
    <div>
      <div className='header'>
        <div><img src={logo} alt="logo" /></div>
            <div><Link to='/' >Home</Link></div>
            <div ><Link to='/templates'  >Templates</Link></div>
            <div ><Link to='/creation_page'>Build Resume</Link></div>
        <div style={{marginLeft:'35em'}}>
          <a href='/'>Sign In</a>
        </div>
        <img src={def} style={{marginLeft:'2em'}} href='/' alt="" />
      </div>
    </div>
  );
}
