import Base from "./Base";
import Channels from "./controllers/Channels";
import Notes from "./controllers/Notes";
import Places from "./controllers/Places";

global.$ = global.jQuery = require("jquery");

const App = {
  Base,
  Channels,
  Notes,
  Places
};

export default App;
