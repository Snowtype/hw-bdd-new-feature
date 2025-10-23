Feature: Find Movies with Same Director
  In order to find movies with the same director
  As a movie enthusiast
  I want to be able to find movies that share the same director

  Background:
    Given the following movies exist:
      | title | rating | director | release_date |
      | Alien | R | Ridley Scott | 1979-05-25 |
      | Blade Runner | R | Ridley Scott | 1982-06-25 |
      | Star Wars | PG | George Lucas | 1977-05-25 |
      | THX-1138 | R | George Lucas | 1971-03-11 |

  Scenario: I can add director info to an existing movie
    Given I am on the edit page for "Alien"
    When I fill in "Director" with "Ridley Scott"
    And I press "Update Movie Info"
    Then I should be on the details page for "Alien"
    And I should see "Ridley Scott"

  Scenario: I can find movies with the same director
    Given I am on the details page for "Alien"
    When I follow "Find Movies With Same Director"
    Then I should be on the Similar Movies page for "Alien"
    And I should see "Alien"
    And I should see "Blade Runner"
    And I should not see "Star Wars"
    And I should not see "THX-1138"

  Scenario: I get a helpful message when a movie has no director info
    Given I am on the details page for "Alien"
    And "Alien" has no director info
    When I follow "Find Movies With Same Director"
    Then I should be on the home page
    And I should see "Alien has no director info"

  Scenario: I can create a new movie
    Given I am on the home page
    When I follow "Add new movie"
    Then I should be on the new movie page
    When I fill in "Title" with "The Matrix"
    And I select "R" from "Rating"
    And I fill in "Director" with "The Wachowskis"
    And I fill in "Release date" with "1999-03-31"
    And I fill in "Description" with "A computer hacker learns about the true nature of reality"
    And I press "Create Movie"
    Then I should be on the details page for "The Matrix"
    And I should see "The Matrix"

  Scenario: I can delete a movie
    Given I am on the home page
    When I follow "Delete" for "Alien"
    Then I should be on the home page
    And I should not see "Alien"

  Scenario: I can visit the new movie page
    Given I am on the home page
    When I follow "Add new movie"
    Then I should be on the new movie page

  Scenario: I can visit the edit movie page
    Given I am on the home page
    When I follow "Edit" for "Alien"
    Then I should be on the edit page for "Alien"

  Scenario: I can visit the details page for a movie
    Given I am on the home page
    When I follow "More about" for "Alien"
    Then I should be on the details page for "Alien"
    And I should see "Alien"

  Scenario: I can navigate back from movie details to home page
    Given I am on the details page for "Alien"
    When I follow "Back to movies"
    Then I should be on the home page
