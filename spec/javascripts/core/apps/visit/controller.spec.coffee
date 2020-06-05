import Controller from 'javascripts/core/apps/visit/controller'
import FormView from 'javascripts/core/apps/visit/form-view'
import { AppChan } from 'javascripts/core/channels'
import sinon from 'sinon'

describe("Visit Controller", () ->
  MyModel = Backbone.Model.extend({
    urlRoot: "/visit"

    validation:
      patient_id:
        required: true
  })

  beforeEach ->
    myModel = new MyModel({
      patients: []
    })

    @myView = Controller._getFormView(myModel)

  describe("::onVisitSave", () ->
    beforeEach ->
      @server = sinon.fakeServer.create()
      @myView.render()

    afterEach ->
      @server.restore()

    it("should validate the view before saving", () ->
      spyOn(@myView.model, 'isValid')
      @myView.triggerMethod('visit:save', @myView)
      expect(@myView.model.isValid).toHaveBeenCalled()
    )

    it("should do not save when validation failed", () ->
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('visit:save', @myView)
      expect(@myView.model.save).not.toHaveBeenCalled()
    )

    it("should save the model when validation did not fail", () ->
      @myView.model.set('patient_id', 7)
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('visit:save', @myView)
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
        @server.respondWith("/visit",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('visit:save', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
        expect(@spy.error).not.toHaveBeenCalled()
      )

      it("calls the error callback when the response is otherwise", () ->
        @server.respondWith("/visit",
                         [
                           422,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('visit:save', @myView)
        @server.respond()

        expect(@spy.error).toHaveBeenCalled()
        expect(@spy.success).not.toHaveBeenCalled()
      )
    )
  )

  describe("::onVisitConfirmDelete", () ->
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

        @server.respondWith("DELETE", "/visit/1",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('visit:confirm:delete', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
      )
    )
  )
)
