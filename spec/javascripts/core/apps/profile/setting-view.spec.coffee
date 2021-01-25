import SettingView from 'javascripts/core/apps/profile/setting-view'

describe("Profile Setting View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#main-region'
  })

  beforeEach ->
    @myRegion = new MyRegion
    @myView = new SettingView {model: new Backbone.Model }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )
  )

  describe("after rendering", () ->
    it("should add the active class to current setting", () ->
      myView = new SettingView({
        model: new Backbone.Model
        setting: "email"
      })

      myView.render()

      expect(myView.$el.find('a[href$="/email"]').parent()).toHaveClass('active')
    )
  )
)
