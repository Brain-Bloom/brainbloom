const AWS = require('aws-sdk');
const fs = require('fs');

// Set your AWS region
AWS.config.update({ region: 'eu-west-1' });

const docClient = new AWS.DynamoDB.DocumentClient();

// Read the JSON data from the file
const jsonData = JSON.parse(fs.readFileSync('courses.json'));

// Define the DynamoDB table name
const tableName = 'dev-courses';

// Function to insert an item into DynamoDB
function putItem(item) {
  const params = {
    TableName: tableName,
    Item: item,
  };

  docClient.put(params, (err, data) => {
    if (err) {
      console.error('Error inserting data:', err);
    } else {
      console.log('Data inserted successfully:', item);
    }
  });
}

// Iterate over each item in the JSON data and insert it into DynamoDB
jsonData.forEach((item) => {
  putItem(item);
});
