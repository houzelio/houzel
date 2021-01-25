import Controller from 'javascripts/core/apps/patient/controller'
import FormView from 'javascripts/core/apps/patient/form-view'
import { AppChan } from 'javascripts/core/channels'
import sinon from 'sinon'

describe("Patient Controller", () ->
  MyModel = Backbone.Model.extend({
    urlRoot: "/patient"

    validation:
      name:
        required: true
  })

  beforeEach ->
    myModel = new MyModel

    @myView = Controller._getFormView(myModel)

  describe("::onPatientSave", () ->
    beforeEach ->
      @server = sinon.fakeServer.create()
      @myView.render()

    afterEach ->
      @server.restore()

    it("should validate the view before saving", () ->
      spyOn(@myView.model, 'isValid')
      @myView.triggerMethod('patient:save', @myView)
      expect(@myView.model.isValid).toHaveBeenCalled()
    )

    it("should do not save when validation failed", () ->
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('patient:save', @myView)
      expect(@myView.model.save).not.toHaveBeenCalled()
    )

    it("should save the model when validation did not fail", () ->
      @myView.model.set('name', "Sofia Grimes")
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('patient:save', @myView)
      expect(@myView.model.save).toHaveBeenCalled()
    )

    describe("after syncing", () ->
      beforeEach ->
        @server = sinon.fakeServer.create()

        @spy = jasmine.createSpyObj('spy', ['success', 'error'])

        model = @myView.model
        model.set('name', "Sofia Grimes")
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
        @server.respondWith("/patient",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('patient:save', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
        expect(@spy.error).not.toHaveBeenCalled()
      )

      it("calls the error callback when the response is otherwise", () ->
        @server.respondWith("/patient",
                         [
                           422,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('patient:save', @myView)
        @server.respond()

        expect(@spy.error).toHaveBeenCalled()
        expect(@spy.success).not.toHaveBeenCalled()
      )
    )
  )

  describe("::onPatientConfirmDelete", () ->
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

        @server.respondWith("DELETE", "/patient/1",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('patient:confirm:delete', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
      )
    )
  )
)
