import NotifierCmp from 'javascripts/core/components/toast-notifier'
import toast from 'izitoast'

describe("Toast Nofifier Component", () ->
  beforeAll ->
    @myNotifier = new NotifierCmp()

  afterEach ->
    toast.destroy()

  describe("::show", () ->
    it("throws an exception if a notifier is invalid", () ->
      expect(() =>
        @myNotifier.show()
      ).toThrowError("A valid notifier is required.")
    )

    it("shows message on screen", (done) ->
      @myNotifier.show('info', "It's a notification message", timeout: 100)
      setTimeout( () ->
        expect($('body')).toContainText("It's a notification message")
        done()
      , 100)
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['opening', 'opened', 'closing', 'closed'])

    it("triggers the Opening event", () ->
      @myObject.listenTo(@myNotifier, 'notifier:opening', @spy.opening)
      @myNotifier._notifierEvents().onOpening()
      expect(@spy.opening).toHaveBeenCalled()
    )

    it("triggers the Opened event", () ->
      @myObject.listenTo(@myNotifier, 'notifier:opened', @spy.opened)
      @myNotifier._notifierEvents().onOpened()
      expect(@spy.opened).toHaveBeenCalled()
    )


    it("triggers the Closing event", () ->
      @myObject.listenTo(@myNotifier, 'notifier:closing', @spy.closing)
      @myNotifier._notifierEvents().onClosing()
      expect(@spy.closing).toHaveBeenCalled()
    )

    it("triggers the Closed event", () ->
      myNotifier = new NotifierCmp()
      myNotifier.off("notifier:closed")

      @myObject.listenTo(myNotifier, 'notifier:closed', @spy.closed)
      myNotifier._notifierEvents().onClosed()
      expect(@spy.closed).toHaveBeenCalled()
    )
  )
)
