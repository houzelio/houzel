import Router from 'javascripts/core/apps/patient/app-route'

describe("Patient App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['listPatients', 'newPatient', 'showPatient'])

    controller =  {
      listPatients: @spy.listPatients
      newPatient: @spy.newPatient
      showPatient: @spy.showPatient
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->  
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('patient', true)
    @myRouter.navigate('patient/new', true)
    @myRouter.navigate('patient/1', true)

    expect(@spy.listPatients).toHaveBeenCalled()
    expect(@spy.newPatient).toHaveBeenCalled()
    expect(@spy.showPatient).toHaveBeenCalled()
  )
)
