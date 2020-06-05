import PickerCmp from 'javascripts/core/components/datepicker'

describe("Picker Component", () ->
  beforeEach ->
    setFixtures(__html__['my-calendar.html'])
    @myPicker = new PickerCmp(el: '#picker-in')

  afterEach ->
    @myPicker.currentPicker.destroy()

  describe("initializing", () ->
    it("attachs picker to DOM", () ->
      expect($('.flatpickr-calendar')).toBeInDOM()
    )

    it("should format date by locale if a formatting is not passed", () ->
      expect(@myPicker.getOption('dateFormat', 'pickerOptions')).toBe('Y/m/d')
    )
  )

  describe("Events", () ->
    beforeEach ->
      @myObject = new Marionette.MnObject
      @spy = jasmine.createSpyObj('spy', ['open', 'change', 'update', 'close'])

    it("triggers an Open event", () ->
      @myObject.listenTo(@myPicker, 'picker:open', @spy.open)
      @myPicker.currentPicker.config['onOpen'][0]()
      expect(@spy.open).toHaveBeenCalled()
    )

    it("triggers a Change event", () ->
      @myObject.listenTo(@myPicker, 'picker:change', @spy.change)
      @myPicker.currentPicker.config['onChange'][0]()
      expect(@spy.change).toHaveBeenCalled()
    )

    it("triggers an Update event", () ->
      @myObject.listenTo(@myPicker, 'picker:update', @spy.update)
      @myPicker.currentPicker.config['onValueUpdate'][0]()
      expect(@spy.update).toHaveBeenCalled()
    )

    it("triggers a Close event", () ->
      @myObject.listenTo(@myPicker, 'picker:close', @spy.close)
      @myPicker.currentPicker.config['onClose'][0]()
      expect(@spy.close).toHaveBeenCalled()
    )
  )
)
