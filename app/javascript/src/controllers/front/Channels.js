import Base from "../../Base";

export default class FrontChannels extends Base {
  show(vars) {
    const map = setMap();
    for (let i = 0; i < vars.length; i++) { setMarker(map, vars[i]['lat'], vars[i]['lng']); }
  }
}

const setMap = () => {
  // center の情報を位置情報から取得するようにする
  const map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 9.927698, lng: -84.0695952},
    zoom: 13
  });

  return map
}

const setMarker = (map, lat, lng) => {
  const markerLatLng = new google.maps.LatLng({ lat, lng });
  const marker = new google.maps.Marker({
    position: markerLatLng,
    map: map
  });

  return marker;
}
