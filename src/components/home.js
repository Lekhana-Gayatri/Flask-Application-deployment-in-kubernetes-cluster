import React from 'react'
import pic2 from './sidepic.jpg';
import pic from './pic2.jpg';
import Button from './button';
import Image from './image';

export default function home() {
    const handleClick=()=>
    {

    }
    return (
        <div className='rlt'>
            <div className='content'>
                <div className='left'style={{padding: '9em 5em 5em 5em'}}>
                <h1>The Best Online Resume Builder</h1>
                <h4>
                    Try our resume builder now for free. Our online resume builder offers a quick and easy way to create your professional resume from over 30 professional resume templates.
                     Create a resume using our AI-powered online resume wizard, which optimizes your resume for applicant tracking systems.
                     Plus, take advantage of expert suggestions and customizable modern and professional resume templates. 
                     Free users have access to our easy-to-use tool and TXT file downloads.</h4>
                     <Button text="Build Resume" navBuild={handleClick} size={{width:250,height:40}}/>
                </div>
                <div className='left' style={{padding: '9em 5em 5em 5em'}}>

                <Image url={pic} alt='resume' />
                </div>
            </div>
            <h1 style={{textAlign:'center'}}> A Quick and Easy Way To Create Your Professional Resume</h1>
                <div className='content'>
                <Image url={pic2} alt='resume'  />
                <div className='left'>
                <h4>&#xf14a; 30+ Professional Resume Templates</h4><h5>Choose from over 30 modern and professional templates, all of which can be customized to your liking.</h5>

                <h4>&#xf14a; Premium Feature: PDF Resume Downloads</h4><h5>Download your resume and send it straight to the hiring manager. Whatever format you choose, we’ve got you covered.<br/> TXT downloads are available for free for all users.</h5>

                <h4>&#xf14a; Robust Text Editor</h4><h5>Our text editor has everything you need to customize your resume. Choose different fonts, sizes, bullets, and much more.</h5>

                <h4>&#xf14a; Fast, Easy to Use, and Free to Start</h4><h5>Our resume builder lets you easily and quickly create this important document using our resume wizard.</h5>
                </div>
                </div>
        </div>
    )
}
