import UserView from 'javascripts/core/apps/admin/user-view'
import LayoutMgr from 'javascripts/core/helpers/layout-manager'
import { AppChan } from 'javascripts/core/channels'

describe("Admin User View", () ->
  MyRegion = Marionette.Region.extend({
    el: '#setting-region'
  })

  beforeAll ->
    $('#main-region').empty()

  beforeEach ->
    setFixtures(__html__['setting-region.html'])

    myCollection = new Backbone.Collection([
      new Backbone.Model({id: 2, name: "Luccas Marks", role_name: "user"})
    ])

    @myRegion = new MyRegion
    @myView = new UserView {collection: myCollection }

  describe("after initializing", () ->
    it("should exist", () ->
      expect(@myView).toBeTruthy()
    )

    it("should instance a new grid", () ->
      expect(@myView.grid).toBeTruthy()
    )
  )

  describe("when attaching", () ->
    beforeEach ->
      spyOn(@myView.grid, 'showView').and.callThrough()
      myRegion = new MyRegion
      myRegion.show(@myView)

    it("shows the grid component", () ->
      expect(@myView.grid.showView).toHaveBeenCalled()
    )

    it("should show the elements when it exists on DOM", () ->      
      expect(@myView.$el.find('.table td').closest('tr').length).toBe(1)
    )
  )

  describe("when the user is an admin", () ->
    beforeAll ->
      @user = _.clone(gon.user)
      gon.user.admin = true

    afterAll ->
      gon.user = @user

    beforeEach ->
      @myRegion.show(@myView)

    it("allows to remove an user", () ->
      expect(@myView.$el.find('a[data-remove="true"]').length).toBe(1)
    )

    describe("after showing the warn dialog", () ->
      beforeEach ->
        @myObject = new Marionette.MnObject
        @spy = jasmine.createSpy('spy')

        @myObject.listenTo(@myView, 'admin:remove:user', @spy)

        @myView.$el.find('a[data-remove="true"]').click()

      it("triggers the Remove User event whether it's agreed ", () ->
        $('button[data-bb-handler="confirm"]').click()
        expect(@spy).toHaveBeenCalled()
      )

      it("does not trigger the Remove User event whether it's canceled", () ->
        $('button[data-bb-handler="cancel"]').click()
        expect(@spy).not.toHaveBeenCalled()
      )
    )
  )

  describe("when the user ain't an admin", () ->
    it("allows not to remove an user", () ->
      expect(@myView.$el.find('a[data-remove="true"]').length).toBe(0)
    )
  )
)
