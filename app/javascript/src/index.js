import Base from "./Base";
import FrontChannels from "./controllers/front/Channels";
import FrontNotes from "./controllers/front/Notes";
import FrontPlaces from "./controllers/front/Places";

global.$ = global.jQuery = require("jquery");

const App = {
  Base,
  FrontChannels,
  FrontNotes,
  FrontPlaces
};

export default App;
