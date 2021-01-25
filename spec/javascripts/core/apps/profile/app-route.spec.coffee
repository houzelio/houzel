import Router from 'javascripts/core/apps/profile/app-route'

describe("Profile App Route", () ->
  beforeAll ->
    @spy = jasmine.createSpyObj('spy', ['editProfile', 'changePassword', 'changeEmail'])

    controller = {
      editProfile: @spy.editProfile
      changePassword: @spy.changePassword
      changeEmail: @spy.changeEmail
    }

    @myRouter = new Router {controller: controller}

    Backbone.history.start()

  afterAll ->
    Backbone.history.stop()

  it("should execute the configured method for matched path", () ->
    @myRouter.navigate('user/profile', true)
    @myRouter.navigate('user/profile/password', true)
    @myRouter.navigate('user/profile/email', true)

    expect(@spy.editProfile).toHaveBeenCalled()
    expect(@spy.changePassword).toHaveBeenCalled()
    expect(@spy.changeEmail).toHaveBeenCalled()
  )
)
