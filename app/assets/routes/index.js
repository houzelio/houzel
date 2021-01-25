import { urlFor, pathFor } from 'webpacker-routes'
const parent_spec = null
const default_url_options = {}
export const appointment_spec = ["/appointment/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const appointment_url = (...args) => urlFor(appointment_spec, ...args)
export const appointment_path = (...args) => pathFor(appointment_spec, ...args)
export const appointment_index_spec = ["/appointment(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const appointment_index_url = (...args) => urlFor(appointment_index_spec, ...args)
export const appointment_index_path = (...args) => pathFor(appointment_index_spec, ...args)
export const destroy_user_session_spec = ["/signout(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const destroy_user_session_url = (...args) => urlFor(destroy_user_session_spec, ...args)
export const destroy_user_session_path = (...args) => pathFor(destroy_user_session_spec, ...args)
export const edit_appointment_spec = ["/appointment/:id/edit(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const edit_appointment_url = (...args) => urlFor(edit_appointment_spec, ...args)
export const edit_appointment_path = (...args) => pathFor(edit_appointment_spec, ...args)
export const edit_invoice_spec = ["/invoice/:id/edit(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const edit_invoice_url = (...args) => urlFor(edit_invoice_spec, ...args)
export const edit_invoice_path = (...args) => pathFor(edit_invoice_spec, ...args)
export const edit_patient_spec = ["/patient/:id/edit(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const edit_patient_url = (...args) => urlFor(edit_patient_spec, ...args)
export const edit_patient_path = (...args) => pathFor(edit_patient_spec, ...args)
export const edit_service_spec = ["/service/:id/edit(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const edit_service_url = (...args) => urlFor(edit_service_spec, ...args)
export const edit_service_path = (...args) => pathFor(edit_service_spec, ...args)
export const edit_visit_spec = ["/visit/:id/edit(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const edit_visit_url = (...args) => urlFor(edit_visit_spec, ...args)
export const edit_visit_path = (...args) => pathFor(edit_visit_spec, ...args)
export const email_profile_index_spec = ["/user/profile/email(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const email_profile_index_url = (...args) => urlFor(email_profile_index_spec, ...args)
export const email_profile_index_path = (...args) => pathFor(email_profile_index_spec, ...args)
export const invoice_spec = ["/invoice/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const invoice_url = (...args) => urlFor(invoice_spec, ...args)
export const invoice_path = (...args) => pathFor(invoice_spec, ...args)
export const invoice_index_spec = ["/invoice(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const invoice_index_url = (...args) => urlFor(invoice_index_spec, ...args)
export const invoice_index_path = (...args) => pathFor(invoice_index_spec, ...args)
export const medical_history_index_spec = ["/medical_history(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const medical_history_index_url = (...args) => urlFor(medical_history_index_spec, ...args)
export const medical_history_index_path = (...args) => pathFor(medical_history_index_spec, ...args)
export const new_appointment_spec = ["/appointment/new(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_appointment_url = (...args) => urlFor(new_appointment_spec, ...args)
export const new_appointment_path = (...args) => pathFor(new_appointment_spec, ...args)
export const new_invoice_spec = ["/invoice/new(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_invoice_url = (...args) => urlFor(new_invoice_spec, ...args)
export const new_invoice_path = (...args) => pathFor(new_invoice_spec, ...args)
export const new_patient_spec = ["/patient/new(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_patient_url = (...args) => urlFor(new_patient_spec, ...args)
export const new_patient_path = (...args) => pathFor(new_patient_spec, ...args)
export const new_service_spec = ["/service/new(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_service_url = (...args) => urlFor(new_service_spec, ...args)
export const new_service_path = (...args) => pathFor(new_service_spec, ...args)
export const new_user_registration_spec = ["/signup(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_user_registration_url = (...args) => urlFor(new_user_registration_spec, ...args)
export const new_user_registration_path = (...args) => pathFor(new_user_registration_spec, ...args)
export const new_user_session_spec = ["/signin(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_user_session_url = (...args) => urlFor(new_user_session_spec, ...args)
export const new_user_session_path = (...args) => pathFor(new_user_session_spec, ...args)
export const new_visit_spec = ["/visit/new(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const new_visit_url = (...args) => urlFor(new_visit_spec, ...args)
export const new_visit_path = (...args) => pathFor(new_visit_spec, ...args)
export const password_profile_index_spec = ["/user/profile/password(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const password_profile_index_url = (...args) => urlFor(password_profile_index_spec, ...args)
export const password_profile_index_path = (...args) => pathFor(password_profile_index_spec, ...args)
export const patient_spec = ["/patient/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const patient_url = (...args) => urlFor(patient_spec, ...args)
export const patient_path = (...args) => pathFor(patient_spec, ...args)
export const patient_index_spec = ["/patient(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const patient_index_url = (...args) => urlFor(patient_index_spec, ...args)
export const patient_index_path = (...args) => pathFor(patient_index_spec, ...args)
export const profile_spec = ["/user/profile/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const profile_url = (...args) => urlFor(profile_spec, ...args)
export const profile_path = (...args) => pathFor(profile_spec, ...args)
export const profile_index_spec = ["/user/profile(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const profile_index_url = (...args) => urlFor(profile_index_spec, ...args)
export const profile_index_path = (...args) => pathFor(profile_index_spec, ...args)
export const root_spec = ["/", [], { ...default_url_options, ...{} }, parent_spec]
export const root_url = (...args) => urlFor(root_spec, ...args)
export const root_path = (...args) => pathFor(root_spec, ...args)
export const service_spec = ["/service/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const service_url = (...args) => urlFor(service_spec, ...args)
export const service_path = (...args) => pathFor(service_spec, ...args)
export const service_index_spec = ["/service(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const service_index_url = (...args) => urlFor(service_index_spec, ...args)
export const service_index_path = (...args) => pathFor(service_index_spec, ...args)
export const user_spec = ["/user/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const user_url = (...args) => urlFor(user_spec, ...args)
export const user_path = (...args) => pathFor(user_spec, ...args)
export const user_registration_spec = ["/signup(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const user_registration_url = (...args) => urlFor(user_registration_spec, ...args)
export const user_registration_path = (...args) => pathFor(user_registration_spec, ...args)
export const user_session_spec = ["/signin(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const user_session_url = (...args) => urlFor(user_session_spec, ...args)
export const user_session_path = (...args) => pathFor(user_session_spec, ...args)
export const users_role_spec = ["/admin/users(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const users_role_url = (...args) => urlFor(users_role_spec, ...args)
export const users_role_path = (...args) => pathFor(users_role_spec, ...args)
export const visit_spec = ["/visit/:id(.:format)", ["id","format"], { ...default_url_options, ...{} }, parent_spec]
export const visit_url = (...args) => urlFor(visit_spec, ...args)
export const visit_path = (...args) => pathFor(visit_spec, ...args)
export const visit_index_spec = ["/visit(.:format)", ["format"], { ...default_url_options, ...{} }, parent_spec]
export const visit_index_url = (...args) => urlFor(visit_index_spec, ...args)
export const visit_index_path = (...args) => pathFor(visit_index_spec, ...args)
