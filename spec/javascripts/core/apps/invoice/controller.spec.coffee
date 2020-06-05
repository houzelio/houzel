import Controller from 'javascripts/core/apps/invoice/controller'
import FormView from 'javascripts/core/apps/invoice/form-view'
import { AppChan } from 'javascripts/core/channels'
import sinon from 'sinon'

describe("Invoice Controller", () ->
  MyModel = Backbone.Model.extend({
    urlRoot: "/invoice"

    validation:
      patient_id:
        required: true
  })

  beforeEach ->
    myModel = new MyModel({
      patients: [], services: []
    })

    @myView = Controller._getFormView(myModel)

  describe("::onInvoiceSave", () ->
    beforeEach ->
      @server = sinon.fakeServer.create()
      @myView.render()

    afterEach ->
      @server.restore()

    it("should validate the view before saving", () ->
      spyOn(@myView.model, 'isValid')
      @myView.triggerMethod('invoice:save', @myView)
      expect(@myView.model.isValid).toHaveBeenCalled()
    )

    it("should do not save when validation failed", () ->
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('invoice:save', @myView)
      expect(@myView.model.save).not.toHaveBeenCalled()
    )

    it("should save the model when validation did not fail", () ->
      @myView.model.set('patient_id', 7)
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('invoice:save', @myView)
      expect(@myView.model.save).toHaveBeenCalled()
    )

    describe("after syncing", () ->
      beforeEach ->
        @server = sinon.fakeServer.create()

        @spy = jasmine.createSpyObj('spy', ['success', 'error'])

        model = @myView.model
        model.set('patient_id', 7)
        save = _.bind(model.save, model)
        spyOn(model, 'save').and.callFake( (data, options) =>
          save(data, {
            success: @spy.success
            error: @spy.error
          })
        )

      afterEach ->
        @server.restore()

      it("calls the success callback when the response is successful", () ->
        @server.respondWith("/invoice",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('invoice:save', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
        expect(@spy.error).not.toHaveBeenCalled()
      )

      it("calls the error callback when the response is otherwise", () ->
        @server.respondWith("/invoice",
                         [
                           422,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('invoice:save', @myView)
        @server.respond()

        expect(@spy.error).toHaveBeenCalled()
        expect(@spy.success).not.toHaveBeenCalled()
      )
    )
  )

  describe("::onInvoiceConfirmDelete", () ->
    describe("after syncing", () ->
      beforeEach ->
        @server = sinon.fakeServer.create()

        @spy = jasmine.createSpyObj('spy', ['success'])

        @myView = Controller._getFormView(new MyModel(id: 1), true)
        model = @myView.model
        destroy = _.bind(model.destroy, model)
        spyOn(model, 'destroy').and.callFake( (options) =>
          destroy({
            success: @spy.success
          })
        )

      afterEach ->
        @server.restore()

      it("calls the success callback when the response is successful", () ->

        @server.respondWith("DELETE", "/invoice/1",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('invoice:confirm:delete', @myView)
        @server.respond()        

        expect(@spy.success).toHaveBeenCalled()
      )
    )
  )
)
