import Router from 'javascripts/core/apps/invoice/app-route'

describe("Invoice App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['listInvoices', 'newInvoice', 'editInvoice'])

    controller =  {
      listInvoices: @spy.listInvoices
      newInvoice: @spy.newInvoice
      editInvoice: @spy.editInvoice
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->    
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('invoice', true)
    @myRouter.navigate('invoice/new', true)
    @myRouter.navigate('invoice/1', true)

    expect(@spy.listInvoices).toHaveBeenCalled()
    expect(@spy.newInvoice).toHaveBeenCalled()
    expect(@spy.editInvoice).toHaveBeenCalled()
  )
)
