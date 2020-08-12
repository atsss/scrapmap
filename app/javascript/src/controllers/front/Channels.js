import Base from "../../Base";
import { setMap, setMarkerWithMessage } from "../../utils/Map"

export default class FrontChannels extends Base {
  show(vars) {
    const map = setMap(vars.lat, vars.lng);
    for (let i = 0; i < vars.places.length; i++) { setMarkerWithMessage(map, vars.places[i]); }
  }
}
