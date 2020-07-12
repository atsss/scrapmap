import Base from "../Base";

export default class Places extends Base {
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
  }

  index(vars) {
    const map = setMap();
    for (let i = 0; i < vars.length; i++) { setMarker(map, vars[i]['lat'], vars[i]['lng']); }
  }

  show(vars) {
    const map = setMap();
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
