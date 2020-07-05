import Base from "../Base";

export default class Places extends Base {
  index(vars) {
    // center の情報を位置情報から取得するようにする
    const map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 9.927698, lng: -84.0695952},
      zoom: 14
    });

    let marker = [];
    for (let i = 0; i < vars.length; i++) {
      const markerLatLng = new google.maps.LatLng({lat: vars[i]['lat'], lng: vars[i]['lon']});
      marker[i] = new google.maps.Marker({
        position: markerLatLng,
        map: map
      });
    }
  }

  new() {
    navigator.geolocation.getCurrentPosition(
      setLocation,
      (error) => console.log('GPS get location error: ', error.message),
      { enableHighAccuracy: true }
  );
  }
}

const setLocation = position => {
  $('#js-lat').val(position.coords.latitude)
  $('#js-lon').val(position.coords.longitude)
  console.log('lat: ', position.coords.latitude);
  console.log('lon: ', position.coords.longitude);
}
