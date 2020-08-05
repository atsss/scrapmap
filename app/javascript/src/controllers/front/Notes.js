import Base from "../../Base";

export default class FrontNotes extends Base {
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
}
