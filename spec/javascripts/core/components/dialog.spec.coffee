import DialogCmp from 'javascripts/core/components/dialog'

describe("Dialog Component", () ->
  beforeAll ->
    @myDialog = new DialogCmp(title: 'My Dialog')

  afterEach ->
    $('.bootbox.modal, .modal-backdrop').remove()

  describe("::show", () ->
    it("throws an exception if a dialog is invalid", () ->
      expect(() =>
        @myDialog.show()
      ).toThrowError("A valid dialog is required.")
    )

    it("shows dialog with message on screen", () ->
      @myDialog.show('alert', "It's my dialog")
      expect($('body')[0]).toContainText("It's my dialog")
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['action_result', 'shown_modal'])

      @myObject.listenTo(@myDialog, 'dialog:action:result', @spy.action_result)
      @myObject.listenTo(@myDialog, 'dialog:shown:modal', @spy.shown_modal)

      @myDialog.show('alert', "Just showing again")

    it("triggers the Action Result event", () ->
      $('button[data-bb-handler="ok"]').click()
      expect(@spy.action_result).toHaveBeenCalled()
    )

    it("triggers the Shown Modal event", () ->
      $('.bootbox').trigger('shown.bs.modal')
      expect(@spy.shown_modal).toHaveBeenCalled()
    )
  )
)
