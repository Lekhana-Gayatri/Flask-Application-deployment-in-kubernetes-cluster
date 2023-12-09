import React from 'react';

export default function image(props) {
  return (
    <div>
      <img src={props.url} alt={props.alt} className='fullimage'/>
    </div>
  )
}
