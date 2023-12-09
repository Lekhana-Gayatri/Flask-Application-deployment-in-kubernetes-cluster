import './App.css';
import Navbar from  './components/navbar';
import Home from  './components/home';
import Templates from  './components/templates';
import Footer from './components/footer';
import CreationPage from './components/creation_page';
import {BrowserRouter as Router,Routes,
  Route} from 'react-router-dom';
function App() {
  return (
    <div>
      <Router>
     <Navbar/>
    <div>
     <Routes>
    <Route path='/' element={ <Home />}/>
    <Route path='/templates' element={ <Templates/>}/>
    <Route path='/creation_page' element={ <CreationPage/>}/>
     </Routes>
    </div>
    <Footer/>
      </Router>
    </div>
  );
}

export default App;
