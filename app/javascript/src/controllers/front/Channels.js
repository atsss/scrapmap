import Base from "../../Base";
import { setMap, setMarkerWithMessage } from "../../utils/Map"

export default class FrontChannels extends Base {
  show(vars) {
    const map = setMap();
    for (let i = 0; i < vars.length; i++) { setMarkerWithMessage(map, vars[i]); }
  }
}
