postData('http://192.168.1.113', {answer: 42})
  .then(data => console.log(data))
  .catch(error => console.error(error))

function postData(url, data) {
  return fetch(url, {
    headers: {
      'content-type': 'application/json'
    },
    method: 'POST',
    body: JSON.stringify(data)
  })
  .then(response => response.json())
}