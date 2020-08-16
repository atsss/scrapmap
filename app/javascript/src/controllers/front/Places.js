import Base from "../../Base";
import { setLocation, setMap, setMarker } from "../../utils/Map"
import LocationPicker from "location-picker";

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

  show(vars) {
    const map = setMap(vars['lat'], vars['lng']);
    setMarker(map, vars['lat'], vars['lng']);
  }

  new() {
    const onIdlePositionView = document.getElementById('onIdlePositionView');
    const lp = new LocationPicker('map', { setCurrentPosition: true }, { zoom: 15 });

    const location = lp.getMarkerPosition();
    const position = getPosition(location);
    setLocation(position);

    google.maps.event.addListener(lp.map, 'idle', function (event) {
      const newLocation = lp.getMarkerPosition();
      const newPosition = getPosition(newLocation);
      setLocation(newPosition);
    });
  }

  edit(vars) {
    const onIdlePositionView = document.getElementById('onIdlePositionView');
    const lp = new LocationPicker('map', { lat: vars['lat'], lng: vars['lng'], zoom: 15 });

    const location = lp.getMarkerPosition();
    const position = getPosition(location);
    setLocation(position);

    google.maps.event.addListener(lp.map, 'idle', function (event) {
      const newLocation = lp.getMarkerPosition();
      const newPosition = getPosition(newLocation);
      setLocation(newPosition);
    });
  }
}

const getPosition = location => {
  let position = { coords: {} };

  position.coords.latitude = location.lat;
  position.coords.longitude = location.lng;

  return position;
}
