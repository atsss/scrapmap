import Base from "../../Base";

export default class FrontChannels extends Base {
  show(vars) {
    const map = setMap();
    for (let i = 0; i < vars.length; i++) { setMarker(map, vars[i]); }
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

const setMarker = (map, place) => {
  const markerLatLng = new google.maps.LatLng({ lat: place['lat'], lng: place['lng'] });
  const marker = new google.maps.Marker({
    position: markerLatLng,
    map: map
  });

  attachMessage(marker, place);

  return marker;
}

const attachMessage = (marker, place) => {
  const content = `
    <div class='a-texts_default'>
      ${place['name']} visited by ${place['vistors']}
      <br>
      <a class='u-mt8 a-link' href=${place['path']}>See more</a>
    </div>
  `;

  google.maps.event.addListener(marker, 'click', function(event) {
    new google.maps.InfoWindow({ content }).open(marker.getMap(), marker);
  });
}
