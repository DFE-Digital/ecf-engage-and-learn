describe("Accessibility", () => {
  it("Govspeak should be accessible", () => {
    cy.visit("/govspeak_test");

    cy.readFile("cypress/fixtures/govspeak-all.txt").then((text) => {
      // We can't use .type() here as it massively slows down the test
      cy.get("#preview-string-field").invoke(
        "val",
        `${text}\n\n${text.replace("Youtube title", "Youtube title 2")}`
      );
    });

    cy.contains("See preview").click();

    cy.checkA11y();
  });

  // This test should only be ran locally due to the length of time taken to complete.
  // To include it add '--env tags=checkCourseLessonsAccessibility' to the yarn cypress:open cmd.
  if (!Cypress.env("tags")?.includes("checkCourseLessonsAccessibility")) {
    it("Visit all course lessons to check for accessibility", () => {
      cy.app("load_seed");
      cy.login("admin");
      cy.appEval(`CourseLessonPart.all`).then((lessonParts) => {
        cy.wrap(lessonParts).each((part) => {
          cy.visitLessonPart(part);
          cy.checkA11y();
        });
      });
    });

    it("Visit all mentor materials to check for accessiblity", () => {
      cy.app("load_seed");
      cy.login("admin");
      cy.appEval(`MentorMaterial.all.map(&:id)`).then((ids) => {
        cy.wrap(ids).each((id) => {
          cy.visit(`/mentor-materials/${id}`);
          cy.checkA11y();
        });
      });
    });
  }
});
