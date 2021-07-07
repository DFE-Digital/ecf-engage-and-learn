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
  if (Cypress.env("tags")?.includes("checkCourseLessonsAccessibility")) {
    describe("Slow accessibility tests", () => {
      it("Visit all course lessons to check for accessibility", () => {
        cy.app("load_seed");
        cy.login("admin");
        cy.appEval(
          `CourseLessonPart
            .includes(course_lesson: { course_module: { course_year: [:core_induction_programme] }}).all
            .map { |part| {
              part: part.to_param,
              lesson: part.course_lesson.to_param,
              module: part.course_lesson.course_module.to_param,
              year: part.course_lesson.course_module.course_year.to_param,
              cip: part.course_lesson.course_module.course_year.core_induction_programme.to_param
           }}`
        ).then((lessonParts) => {
          const skip = [
            "/teach-first/year-1/spring-2/topic-5/part-2", // Accordion messing up heading levels
            "/ucl/year-1/autumn-2/topic-3/part-3", // Duplicate titles in sections causing duplicate IDs
            "/ucl/year-1/summer-1/topic-5/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/summer-2/topic-4/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/autumn-1/topic-2/part-6", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/autumn-1/topic-3/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/autumn-1/topic-5/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/spring-1/topic-2/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/spring-1/topic-3/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/spring-1/topic-7/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/spring-2/topic-4/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/spring-2/topic-7/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/summer-1/topic-5/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/summer-1/topic-8/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/summer-2/topic-2/part-3", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-1/summer-2/topic-4/part-6", // Duplicate titles in sections causing duplicate IDs
            "/edt/year-2/autumn-1/topic-3/part-3", // Duplicate titles in sections causing duplicate IDs
          ];

          cy.wrap(lessonParts).each((part) => {
            const url = `/${part.cip}/${part.year}/${part.module}/${part.lesson}/${part.part}`;

            if (skip.includes(url)) {
              return;
            }

            cy.visit(url);
            cy.checkA11y();
          });
        });
      });

      it("Visit all mentor materials to check for accessibility", () => {
        cy.app("load_seed");
        cy.login("admin");
        cy.appEval(
          `MentorMaterialPart
            .includes(mentor_material: { course_lesson: { course_module: { course_year: [:core_induction_programme] }}}).all
            .map { |part| {
              part: part.to_param,
              material: part.mentor_material.to_param,
              lesson: part.mentor_material.course_lesson.to_param,
              module: part.mentor_material.course_lesson.course_module.to_param,
              year: part.mentor_material.course_lesson.course_module.course_year.to_param,
              cip: part.mentor_material.course_lesson.course_module.course_year.core_induction_programme.to_param
           }}`
        ).then((ids) => {
          const skip = [
            "/edt/year-1/autumn-1/topic-5/mentoring/1/part-2", // Sections messing up heading IDs - duplicates
          ];

          cy.wrap(ids).each((part) => {
            const url = `/${part.cip}/${part.year}/${part.module}/${part.lesson}/mentoring/${part.material}/${part.part}`;

            if (skip.includes(url)) {
              return;
            }

            cy.visit(url);
            cy.checkA11y();
          });
        });
      });
    });
  }
});
