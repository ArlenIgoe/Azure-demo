// Define a constant called apiUrl which is the URL of the Azure Functions API
const apiUrl = "https://function-ps-portal.azurewebsites.net/api/HttpTrigger?code=";

// Define a constant called appendUrl which is the API key for accessing the Azure Functions API
const appendUrl = "KqMXSZmDig26wkDrih7Wz3pN7PSWYsKIp8quM60YDXpBAzFuLv7bCw==";

// Make a fetch request to the API by concatenating the apiUrl and appendUrl constants
fetch([apiUrl, appendUrl].join(''))

    // Parse the response from the API as JSON
    .then(response => {
        return response.json();
    })

    // Log the successful fetch to the console and update the count value and display the result on the page
    .then (response => {
        console.log('Fetch succeeded to function.');
        console.log(response);
        count = response.VisitorCount;
        document.getElementById('visits').innerHTML = 'This page has been visited ' + count + ' times.';
    })

    // Log an error message to the console if the fetch fails
    .catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
        document.getElementById('visits').innerHTML = 'Error: ' + error + '.';
    });