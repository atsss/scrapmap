import Base from "../Base";

export default class Places extends Base {
  index() {
    // center の情報を位置情報から取得するようにする
    const map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 9.927698, lng: -84.0695952},
      zoom: 14
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
