import Base from "./Base";
import Places from "./controllers/Places";

global.$ = global.jQuery = require("jquery");

const App = {
  Base,
  Places
};

export default App;
