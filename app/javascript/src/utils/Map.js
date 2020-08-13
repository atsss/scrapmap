export const setLocation = position => {
  $('.js-lat').val(position.coords.latitude)
  $('.js-lng').val(position.coords.longitude)
  console.log('lat: ', position.coords.latitude);
  console.log('lng: ', position.coords.longitude);
}

const centerPosition = { lat: 35.6809591, lng: 139.7673068 }

export const setMap = (lat = centerPosition.lat, lng = centerPosition.lng) => {
  if(lat == null) { lat = centerPosition.lat; }
  if(lng == null) { lng = centerPosition.lng; }

  const map = new google.maps.Map(document.getElementById('map'), {
    center: { lat, lng },
    zoom: 8
  });

  return map
}

export const setMarker = (map, lat, lng) => {
  const markerLatLng = new google.maps.LatLng({ lat, lng });
  const marker = new google.maps.Marker({
    position: markerLatLng,
    map: map
  });

  return marker;
}

export const setMarkerWithMessage = (map, place) => {
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
