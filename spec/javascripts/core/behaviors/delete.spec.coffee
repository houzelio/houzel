import DeleteBehavior from 'javascripts/core/behaviors/delete'

describe("Delete Behavior", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  MyView = Marionette.View.extend({
    template: _.template(
     '<div class="form-group">
       <button id="delete-btn" class="btn.btn-default">Delete</button>
      </div>'
    )

    behaviors:
      Delete:
        behaviorClass: DeleteBehavior
        triggerEvent: 'view:confirm:delete'
        message: "My warning message"
  })

  beforeEach ->
    setFixtures('<section id="main-region"></section>')

    @myRegion = new MyRegion
    @myView = new MyView

    @myRegion.show(@myView)
    @myView.$el.find('#delete-btn').click()

  it("shows the dialog with the preset message", () ->
    expect($('body')[0]).toContainText("My warning message")
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpy()
      @myObject.listenTo(@myView, 'view:confirm:delete', @spy)

    it("triggers the event by the view", () ->
      $('button[data-bb-handler="confirm"]').click()
      expect(@spy).toHaveBeenCalled()
    )

    it("does nothing whether it's cancelled", () ->
      $('button[data-bb-handler="cancel"]').click()
      expect(@spy).not.toHaveBeenCalled()
    )
  )
)
