import Router from 'javascripts/core/apps/appointment/app-route'

describe("Appointment App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['listAppointments', 'newAppointment', 'editAppointment'])

    controller = {
      listAppointments: @spy.listAppointments
      newAppointment: @spy.newAppointment
      editAppointment: @spy.editAppointment
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->    
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('appointment', true)
    @myRouter.navigate('appointment/new', true)
    @myRouter.navigate('appointment/1', true)

    expect(@spy.listAppointments).toHaveBeenCalled()
    expect(@spy.newAppointment).toHaveBeenCalled()
    expect(@spy.editAppointment).toHaveBeenCalled()
  )
)
