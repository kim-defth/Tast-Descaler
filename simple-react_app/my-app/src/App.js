import { useEffect, useState } from "react";

const BASE_URL = 'https://pryt9yopec.execute-api.us-east-1.amazonaws.com/test/lambda';

function App() {
  const [text, setText] = useState('Default state text before Lambda update');

  useEffect(() => {
    console.log('Attempting to make GET request.');

    fetch(BASE_URL, {method: 'GET'})
      .then(response => {
        console.log('Received response:');
        console.log(response);
        return response.json(); // Convert body to JSON
      })
      .then(data => {
        console.log('Received JSON: ');
        console.log(data);
        setText(data);
      })
      .catch(error => {
        console.log('Received ERROR: ');
        console.error(error);
        setText('Error fetching data from Lambda');
      });
  }, []);


  return (
    <div className="App">
      <h1>Hello World!</h1>
      <p>Lambda response: {text}</p>
    </div>
  );
}

export default App;
