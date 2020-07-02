import Base from "../Base";

export default class Places extends Base {
  index() {
    const map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 8
    });
  }

  new() {
    navigator.geolocation.getCurrentPosition(setLocation);
  }
}

const setLocation = position => {
  $('#js-lat').val(position.coords.latitude)
  $('#js-lon').val(position.coords.longitude)
  console.log('lat: ', position.coords.latitude);
  console.log('lon: ', position.coords.longitude);
}
