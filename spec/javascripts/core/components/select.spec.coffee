import SelectCmp from 'javascripts/core/components/select'

describe("Select Component", () ->
  beforeEach ->
    setFixtures(__html__['my-select.html'])
    @mySelect = new SelectCmp(el: '#my-sel')

  describe("initializing", () ->
    it("shows chosen for select element", () ->
      expect($('#my-sel').next()).toBeMatchedBy('.chosen-container')
    )
  )

  it("should trigger a Change event when a value changes", () ->
    spy = jasmine.createSpy()
    myObject = new Marionette.MnObject
    myObject.listenTo(@mySelect, 'select:change', spy)

    $('#my-sel').trigger('change')

    expect(spy).toHaveBeenCalled()
  )

  describe("::setValue", () ->
    it("changes the value on select", () ->
      @mySelect.setValue(4)
      expect($("#my-sel option:selected").text()).toBe("Luccas Marks")
    )
  )

  describe("::getValue", () ->
    it("gets the value on select", () ->
      $("#my-sel").val(2)
      expect(@mySelect.getValue()).toBe('2')
    )
  )
)
