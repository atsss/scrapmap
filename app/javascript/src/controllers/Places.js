import Base from "../Base";

export default class Places extends Base {
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
