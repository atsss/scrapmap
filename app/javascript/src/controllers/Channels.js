import Base from "../Base";

export default class Channels extends Base {
  show(vars) {
    const map = setMap();
    setMarker(map, vars['lat'], vars['lng']);
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
