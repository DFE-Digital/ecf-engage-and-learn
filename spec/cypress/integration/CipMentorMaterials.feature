Feature: Core Induction Programme mentor materials
  Users should be able to view and sometimes edit mentor material.

  Scenario: Admins can create mentor materials
    Given I am logged in as "admin"
    And I am on "core induction programme mentor materials" page

    When I click on "link" containing "Create Mentor Material"
    Then I should be on "core induction programme mentor material new" page
    And the page should be accessible
    And percy should be sent snapshot

    When I type "New mentor material title" into "title input"
    And I click on "button" containing "Save"

    Then "page body" should contain "Mentor material created"
    And "page body" should contain "New mentor material title"
    And the page should be accessible

  Scenario: Admins can edit mentor materials
    Given I am logged in as "admin"
    Given mentor_material was created as "with_mentor_material_part" with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"
    And I am on "core induction programme mentor material" page with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"

    Then I should have been redirected to "core induction programme mentor material part" page

    When I click on "link" containing "Edit mentor material"
    Then I should be on "core induction programme mentor material edit" page
    And the page should be accessible
    And percy should be sent snapshot

    When I clear "title input"
    And I type "New mentor material title" into "title input"
    When I click on "button" containing "Save"
    Then "page body" should contain "Your changes have been saved"
    And "page body" should contain "New mentor material title"
    And the page should be accessible
