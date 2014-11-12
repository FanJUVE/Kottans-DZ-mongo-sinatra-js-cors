// Create the XHR object.
function createCORSRequest(method, url) {
  var xhr = new XMLHttpRequest();
  if ("withCredentials" in xhr) {
    // XHR for Chrome/Firefox/Opera/Safari.
    xhr.open(method, url, true);
  } else if (typeof XDomainRequest != "undefined") {
    // XDomainRequest for IE.
    xhr = new XDomainRequest();
    xhr.open(method, url);
  } else {
    // CORS not supported.
    xhr = null;
  }
  return xhr;
}

function makeCorsRequest(type, url) {

  var xhr = createCORSRequest(type, url);
  if (!xhr) {
    console.log('CORS not supported');
    return;
  }

  // Response handlers.
  xhr.onload = function() {
    var text = xhr.responseText;
    var title = 'Weather query';
    console.log('Response from CORS request to ' + url + ': ' + title + ': ' + text);
  };

  xhr.onerror = function() {
    console.log('Woops, there was an error making the request.');
  };

  xhr.onreadystatechange = function() {
    if(xhr.readyState == 4 && xhr.status == 200) {
      show_on_page(xhr.responseText);
    }
  }

  xhr.send();
}

// create new cors request
makeCorsRequest('GET', 'http://localhost:8000/todays_weather.json');

// show data on page
function show_on_page(json) {
  var el = document.getElementById('weather-local');
  data = JSON.parse(json);
  html = "";
  data.forEach(function(entry) {
    var date = new Date(entry.date);
    date = date.getDate() + '/' + (date.getMonth()+1) + '/' + date.getFullYear();
    html += "<div><ul><li>"+date+"</li><li>"+entry.city+"</li><li>"+entry.value+"</li><li>"+entry.sky+"</li></ul></div>";
  });
  el.innerHTML = html;
}

