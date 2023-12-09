import React from 'react'

export default function button(props) {
  return (
    <div>
      <button className='btn' onClick={props.navBuild} style={{width:props.size.width,height:props.size.height}}>{props.text}</button>
    </div>
  )
}
