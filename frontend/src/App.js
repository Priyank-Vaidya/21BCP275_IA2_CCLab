import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <nav className="navbar">
        <div className="container">
          <h1 className="logo">Cloud Computing</h1>
          <div className="info">
            <p>Priyank Vaidya</p>
            <p>21BCP275</p>
          </div>
        </div>
      </nav>

      <div className="content-container">
        <div className="image-container">
          <img src="frontend/src/image.jpg" alt="My Image" />
        </div>
        <div className="button-container">
          <button className="get-started-button">Get Started</button>
        </div>
      </div>
    </div>
  );
}

export default App;
