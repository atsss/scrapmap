import Base from "../../Base";

export default class FrontPlaces extends Base {
  beforeAction(actionName) {
    $(".js-input").on("change", function(event) {
      if (event.target.files && event.target.files[0]) {
        const reader = new FileReader();

        let target_class_name = event.target.dataset.target;

        reader.onload = function(e) {
          $(target_class_name).attr("src", e.target.result);
        };

        reader.readAsDataURL(event.target.files[0]);
      }
    });

    $(".js-loading__form").on("submit", ev => {
      $(".js-loading").addClass("is-active");
      $(".js-loading__circle").addClass("m-loading__circle--active");
    });
  }

  index(vars) {
    const map = setMap();
    for (let i = 0; i < vars.length; i++) { setMarker(map, vars[i]['lat'], vars[i]['lng']); }
  }

  show(vars) {
    const map = setMap(vars['lat'], vars['lng']);
    setMarker(map, vars['lat'], vars['lng']);
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
  $('.js-lat').val(position.coords.latitude)
  $('.js-lng').val(position.coords.longitude)
  console.log('lat: ', position.coords.latitude);
  console.log('lng: ', position.coords.longitude);
}

const centerPosition = { lat: 35.6809591, lng: 139.7673068 }

const setMap = (lat = centerPosition.lat, lng = centerPosition.lng) => {
  if(lat == null) { lat = centerPosition.lat; }
  if(lng == null) { lng = centerPosition.lng; }

  console.log(lat, lng);
  const map = new google.maps.Map(document.getElementById('map'), {
    center: { lat, lng },
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
