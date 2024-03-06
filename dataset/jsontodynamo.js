const AWS = require('aws-sdk');
const fs = require('fs');

// Set your AWS region
AWS.config.update({ region: 'eu-west-1' });

const docClient = new AWS.DynamoDB.DocumentClient();

function insertDataIntoDynamoDB(jsonData, tableName, callback) {
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

  // Convert to array if jsonData is an object
  const dataArray = Array.isArray(jsonData) ? jsonData : [jsonData];

  // Iterate over each item in the JSON data and insert it into DynamoDB
  dataArray.forEach((item) => {
    putItem(item);
  });

  // Call the callback function if provided
  if (typeof callback === 'function') {
    callback();
  }
}

// Example usage for courses.json
const coursesData = JSON.parse(fs.readFileSync('courses/courses.json'));
const coursesTableName = 'dev-courses';

insertDataIntoDynamoDB(coursesData, coursesTableName, () => {
  console.log('Insertion for courses.json completed.');
});

// Example usage for users.json
const usersData = JSON.parse(fs.readFileSync('users/users.json'));
const usersTableName = 'dev-users';

insertDataIntoDynamoDB(usersData, usersTableName, () => {
  console.log('Insertion for users.json completed.');
});
