import "stylesheets";
import App from "src";

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("DOMContentLoaded", function() {
  const el = document.querySelector("#js-bootstrap");
  const vars = JSON.parse(el.getAttribute("data-vars"));
  const $this = new (App["" + el.getAttribute("data-controller")] || App.Base)();
  const actionName = el.getAttribute("data-action-name");

  if (typeof $this.beforeAction === "function") {
    $this.beforeAction(actionName, vars);
  }

  if (typeof $this[actionName] === "function") {
    $this[actionName](vars);
  }

  if (typeof $this.afterAction === "function") {
    $this.afterAction(actionName, vars);
  }
});
