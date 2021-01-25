import SettingView from 'javascripts/core/apps/admin/setting-view'

describe("Admin Setting View", () ->
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
)
