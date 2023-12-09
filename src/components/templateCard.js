import React from 'react'
export default function templateCard(props) {
  return (
    <div>
      <div className='card'>
        <img src={props.image} alt='resumeImg'/>
      </div>
    </div>
  )
}
