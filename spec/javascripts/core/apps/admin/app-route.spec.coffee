import Router from 'javascripts/core/apps/admin/app-route'

describe("Admin App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpy('listUsers')

    controller =  {
      listUsers: @spy
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('admin/users', true)

    expect(@spy).toHaveBeenCalled()
  )
)
