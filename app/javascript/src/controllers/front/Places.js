import Base from "../../Base";
import { setLocation, setMap, setMarker } from "../../utils/Map"

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
    navigator.geolocation.getCurrentPosition(
      setLocation,
      (error) => console.log('GPS get location error: ', error.message),
      { enableHighAccuracy: true }
    );
  }
}
