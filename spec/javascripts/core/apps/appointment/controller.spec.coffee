import Controller from 'javascripts/core/apps/appointment/controller'
import FormView from 'javascripts/core/apps/appointment/form-view'
import { AppChan } from 'javascripts/core/channels'
import sinon from 'sinon'

describe("Appointment Controller", () ->
  MyModel = Backbone.Model.extend({
    urlRoot: "/appointment"

    validation:
      examiner_id:
        required: true
  })

  beforeEach ->
    myModel = new MyModel({
      patients: [], examiners: []
    })

    @myView = Controller._getFormView(myModel)

  describe("::onAppointmentSchedule", () ->
    beforeEach ->
      @myView.render()

    it("should validate the view before saving", () ->
      spyOn(@myView.model, 'isValid')
      @myView.triggerMethod('appointment:schedule', @myView)
      expect(@myView.model.isValid).toHaveBeenCalled()
    )

    it("should do not save when validation failed", () ->
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('appointment:schedule', @myView)
      expect(@myView.model.save).not.toHaveBeenCalled()
    )

    it("should save the model when validation did not fail", () ->
      @myView.model.set('examiner_id', 4)
      spyOn(@myView.model, 'save')
      @myView.triggerMethod('appointment:schedule', @myView)
      expect(@myView.model.save).toHaveBeenCalled()
    )

    describe("after syncing", () ->
      beforeEach ->
        @server = sinon.fakeServer.create()

        @spy = jasmine.createSpyObj('spy', ['success', 'error'])

        model = @myView.model
        model.set('examiner_id', 4)
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
        @server.respondWith("/appointment",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('appointment:schedule', @myView)
        @server.respond()

        expect(@spy.success).toHaveBeenCalled()
        expect(@spy.error).not.toHaveBeenCalled()
      )

      it("calls the error callback when the response is otherwise", () ->
        @server.respondWith("/appointment",
                         [
                           422,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('appointment:schedule', @myView)
        @server.respond()

        expect(@spy.error).toHaveBeenCalled()
        expect(@spy.success).not.toHaveBeenCalled()
      )
    )
  )

  describe("::onAppointmentConfirmDelete", () ->
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

        @server.respondWith("DELETE", "/appointment/1",
                         [
                           200,
                           { "Content-Type": "application/json" },
                           JSON.stringify({})
                         ])

        @myView.triggerMethod('appointment:confirm:delete', @myView)
        @server.respond()        

        expect(@spy.success).toHaveBeenCalled()
      )
    )
  )
)
