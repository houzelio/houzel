import { AppChan, ObjChan } from 'channels'
import { showView } from 'helpers/layout-region'
import { Invoice, Patient } from 'entities/index'
import Syphon from 'backbone.syphon'
import FormView from './form-view'

Controller =
  newInvoice: () ->
    invoice = Invoice.create()
    ObjChan.request("when:fetched", invoice, =>
      view = @_getFormView(invoice)
      view.on('invoice:select:patient', @onInvoiceSelectPatient)
      showView(view)
    )

    return

  editInvoice: (id) ->
    invoice = Invoice.get(id)
    ObjChan.request("when:fetched", invoice, =>
      view = @_getFormView(invoice, true)
      showView(view)
    )

    return

  _getFormView: (model, deleteOption) ->
    view = new FormView {model: model}

    view.on('invoice:save', @onInvoiceSave)
    if deleteOption
      view.on('invoice:confirm:delete', @onInvoiceConfirmDelete)

    view

  onInvoiceSelectPatient: (view, id) ->
    patient = Patient.get(id)
    ObjChan.request("when:fetched", patient, =>
      patient = new Patient.create({patient: _.clone(patient.attributes)})
      view.showPatientInfo(patient)
    )

  onInvoiceSave: (view) ->
    model = view.model
    if !model.isValid(true) then return

    data = Syphon.serialize(view)
    model.save(data, {
      error: (model, jqXHR) ->
        view.showRespErrors(jqXHR)
    })

export default Controller
