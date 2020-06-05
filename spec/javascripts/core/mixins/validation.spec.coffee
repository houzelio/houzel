import ValidationMixin from 'javascripts/core/mixins/validation'

describe("Validation Mixin", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  MyModel = Backbone.Model.extend({
    validation:
      name:
        required: true
        msg: "Name is required"
  })

  MyView = Marionette.View.extend({
    template: _.template(
     '<div class="form-group required">
       <input id="name-in" type="text" name="name">
       <span class="help-block"></span>
      </div>
      <div class="form-group">
        <input id="remarks-in" type="text" name="remarks">
      </div>'
    )

    tagName: "div"

    mixins: [ValidationMixin]

    bindings:
      '#name-in' : 'name'
  })

  beforeEach ->
    setFixtures('<section id="main-region"></section>')

    @myRegion = new MyRegion
    @myView = new MyView {model: new MyModel}

  it("should set the modelEvents", () ->
    expect(@myView.modelEvents.validated).toBeDefined()
  )

  describe("::showErrors", () ->
    beforeEach( (done) ->
      showErrors = _.bind(@myView.showErrors, @myView)
      spyOn(@myView, 'showErrors').and.callFake((errors) =>
        showErrors(errors)
        done()
      )

      @myRegion.show(@myView)
      @myView.model.isValid(true)
    )

    it("should call showErrors when the model is validated", () ->
      expect(@myView.showErrors).toHaveBeenCalled()
    )

    it("should show errors for element on view", () ->
      $el = @myView.$el.find('#name-in').closest('.form-group')
      expect($el).toHaveClass("has-error")
      expect($el.find('.help-block')).toContainText("Name is required")
      expect(@myView.$el.find('#remarks-in').closest('.form-group')).not.toHaveClass("has-error")
    )

    it("should empty errors on view when any error is passed", () ->
      @myView.showErrors()

      $el = @myView.$el.find('#name-in').closest('.form-group')
      expect($el).not.toHaveClass("has-error")
      expect($el.find('.help-block')).toBeEmpty()
    )
  )
)
