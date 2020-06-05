import Router from 'javascripts/core/apps/service/app-route'

describe("Service App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['listServices', 'newService', 'editService'])

    controller = {
      listServices: @spy.listServices
      newService: @spy.newService
      editService: @spy.editService
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('service', true)
    @myRouter.navigate('service/new', true)
    @myRouter.navigate('service/1', true)

    expect(@spy.listServices).toHaveBeenCalled()
    expect(@spy.newService).toHaveBeenCalled()
    expect(@spy.editService).toHaveBeenCalled()
  )
)
