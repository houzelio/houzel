import defaultLocale from "../../../../config/locales/javascript/en.yml"
import { initIntl, t } from 'javascripts/core/helpers/i18n'

describe("i18n", () ->
  beforeAll ->
    @defaultLocale = defaultLocale.json['en'].javascripts
    @locale = {
      message: "Hi"
      interpolation: "%{message}"
      namespace:
        message: "Hi from namespace"
        innerNamespace:
          message: "Hi from innerNamespace"
    }

  afterEach ->
    initIntl(phrases: @defaultLocale)

  describe("::initIntl", () ->
    it("overrides existing locale", () ->
      pastLocale = name: "Luna"
      lastLocale = name: "Luccas"
      intl = initIntl(phrases: pastLocale)
      expect(intl.polyglot.phrases.name).toBe("Luna")
      intl = initIntl(phrases: lastLocale)
      expect(intl.polyglot.phrases.name).toBe("Luccas")
    )
  )

  describe("::t", () ->
    beforeEach ->
      initIntl(phrases: @locale, "en")

    it("returns the specified translation", () ->
      translation = t("message");
      expect(translation).toEqual("Hi");
    )

    it("can interpolate values", () ->
      translation = t("interpolation", message: "It works")
      expect(translation).toBe("It works")
    )

    it("will go through nested objects", () ->
      translation = t("namespace.innerNamespace.message")
      expect(translation).toBe("Hi from innerNamespace")
    )

    it("returns the missing key if translation is not found", () ->
      translation = t("missing.translation")
      expect(translation).toBe("missing.translation")
    )

    it("should return the same translation in javascript app and templates", () ->
      localTranslation = t("namespace.message")
      globalTranslation = window.t("namespace.message")
      expect(localTranslation).toBe(globalTranslation)
    )
  )
)
