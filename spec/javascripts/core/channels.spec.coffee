import Radio from 'backbone.radio'
import { AppChan, ObjChan } from 'javascripts/core/channels'

describe("channels", () ->
  beforeEach ->
    Radio.channel('App').reply("event", () ->
      "App Channel"
    )

    Radio.channel('Object').reply("event", () ->
      "Object Channel"
    )

  it("should return 'App' channel events", () ->
    expect(AppChan.request("event")).toBe("App Channel")
  )

  it("should return 'Object' channel events", () ->
    expect(ObjChan.request("event")).toBe("Object Channel")
  )
)
