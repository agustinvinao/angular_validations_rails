module AngularValidationsRailsHelper
  def angularjs_form_for(object, options = {}, &block)
    options[:builder] = AngularFormBuilder
    options[:html] = {} unless options[:html]
    options[:html].merge!({:name => afv_form_name(object.class)})
    content_tag :div, afv_ng_attributes(@contact.class) do
      raw "#{afv_javascript}#{form_for(object, options, &block)}"
    end
  end

  private
  def afv_form_name(model)
    "#{model.to_s.downcase}_form"
  end
  def afv_javascript
    script = <<SCRIPT
angular.module("angularFormValidator", ["angularFormValidator.controllers", "angularFormValidator.directives"]);
angular.module("angularFormValidator.controllers", []).controller("angularFormValidatorCntl", ["$scope", function($scope) {}]);
angular.module("angularFormValidator.directives", []).directive("ngMatch", ['$parse', function ($parse) { 
  var directive = {
    link: link,
    restrict: 'A',
    require: '?ngModel'
  };
  return directive;
  function link(scope, elem, attrs, ctrl) {
    // if ngModel is not defined, we don't need to do anything
    if (!ctrl) return;
    if (!attrs[directiveId]) return;
    var firstPassword = $parse(attrs[directiveId]);
    var validator = function (value) {
      var temp = firstPassword(scope),
      v = value === temp;
      ctrl.$setValidity('match', v);
      return value;
    }
    ctrl.$parsers.unshift(validator);
    ctrl.$formatters.push(validator);
    attrs.$observe(directiveId, function () {
      validator(ctrl.$viewValue);
    });
  }
}]);
SCRIPT
    javascript_tag(script)
  end
  def afv_ng_attributes(model)
    if afv_validate_form? model
      {'ng-app' => AngularValidation.configuration.ng_application_name, 'ng-controller' => AngularValidation.configuration.ng_controller_name, :class => 'angular_validations_rails'}
    else
      {}
    end
  end
  def afv_validate_form?(model)
    AngularValidation.configuration.models.include?(model.to_s)
  end
end