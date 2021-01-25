import Router from 'javascripts/core/apps/visit/app-route'

describe("Visit App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['listVisits', 'newVisit', 'editVisit'])

    controller = {
      listVisits: @spy.listVisits
      newVisit: @spy.newVisit
      editVisit: @spy.editVisit
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->    
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('visit', true)
    @myRouter.navigate('visit/new', true)
    @myRouter.navigate('visit/1', true)

    expect(@spy.listVisits).toHaveBeenCalled()
    expect(@spy.newVisit).toHaveBeenCalled()
    expect(@spy.editVisit).toHaveBeenCalled()
  )
)
