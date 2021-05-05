import { When, Then } from "cypress-cucumber-preprocessor/steps";

const elements = {
  "cookie consent radio": '[name="cookies_form[analytics_consent]"]',
  "cookie banner": ".js-cookie-banner",
  "phase banner": ".govuk-phase-banner",
  "page body": "main",
  "page heading": "h1",
  link: "a",
  button: "button,input[type=submit],input[type=button]",
  "edit name link": '[data-test="edit-name"]',
  "name input": '[name*="name"]',
  "title input": '[name*="title"]',
  "content input": '[name*="content"]',
  "ect summary input": '[name*="ect_summary"]',
  "email input": '[name*="email"]',
  "time input": '[name*="time"]',
  "username input": '[name*="username"]',
  "govspeak content": ".govuk-govspeak",
  "tag component": ".govuk-tag",
  "service name in navigation": '[data-test="service-name"]',
  "service navigation item": ".govuk-header__navigation-item",
  "error summary": ".govuk-error-summary",
};

const get = (element) => cy.get(elements[element] || element);

When("I set {string} to {string}", (element, value) => {
  get(element).get(`[value="${value}"]`).click();
});

When("I clear {string}", (element) => {
  get(element).clear();
});

When("I type {string} into {string}", (value, element) => {
  get(element).type(value);
});

When("I click on {string}", (element) => {
  get(element).click();
});

When("I click on {string} containing {string}", (element, containing) => {
  get(element).contains(containing).click();
});

When("I click on {string} label", (text) => {
  cy.get("label").contains(text).click();
});

When("I click the submit button", () => {
  cy.get("[name=commit]").click();
});

When("I click the back link", () => {
  cy.clickBackLink();
});

Then("{string} should be unchecked", (element) => {
  get(element).should("not.be.checked");
});

Then("{string} with value {string} is checked", (element, value) => {
  get(element).get(`[value="${value}"]`).should("be.checked");
});

Then("{string} should have value {string}", (element, value) => {
  get(element).should("have.value", value);
});

Then("{string} should contain {string}", (element, value) => {
  get(element).should("contain", value);
});

Then("{string} should not contain {string}", (element, value) => {
  get(element).should("not.contain", value);
});

Then("{string} should be hidden", (element) => {
  get(element).should("not.be.visible");
});

Then("{string} should exist", (element) => {
  get(element).should("exist");
});

Then("{string} containing {string} should exist", (element, text) => {
  get(element).contains(text).should("exist");
});

Then("{string} should not exist", (element) => {
  get(element).should("not.exist");
});

Then("{string} containing {string} should not exist", (element, text) => {
  get(element).contains(text).should("not.exist");
});

Then("{string} label should be checked", (text) => {
  cy.get("label")
    .contains(text)
    .invoke("attr", "for")
    .then((inputId) => {
      if (!inputId) {
        throw new Error("for not available on this label");
      }

      cy.get(`#${inputId}`).should("be.checked");
    });
});

Then("{string} label should be unchecked", (text) => {
  cy.get("label")
    .contains(text)
    .invoke("attr", "for")
    .then((inputId) => {
      if (!inputId) {
        throw new Error("for not available on this label");
      }

      cy.get(`#${inputId}`).should("not.be.checked");
    });
});
