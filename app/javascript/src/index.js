import Base from "./Base";
import Places from "./controllers/Places";
import Notes from "./controllers/Notes";

global.$ = global.jQuery = require("jquery");

const App = {
  Base,
  Places,
  Notes
};

export default App;
