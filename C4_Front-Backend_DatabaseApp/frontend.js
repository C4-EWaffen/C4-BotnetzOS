import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [connections, setConnections] = useState([]);

  useEffect(() => {
    axios.get('/connections')
      .then(response => setConnections(response.data))
      .catch(error => console.error('Error fetching connections:', error));
  }, []);

  return (
    <div>
      <h1>Network Connections</h1>
      <ul>
        {connections.map(conn => (
          <li key={conn.id}>{conn.type}: {conn.details}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
