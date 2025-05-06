Feature: Product Admin UI

  As a Product Administrator
  I need a web interface to manage Products
  So that I can keep track of all Products

  Background:
    Given the following products
      | name    | description    | price | available | category |
      | Hat     | A red fedora   | 59.95 | True      | Cloths   |
      | Shoes   | Running shoes  | 89.99 | False     | Sports   |
      | Big Mac | Fast food item | 5.99  | True      | Food     |
      | Sheets  | Bed sheets     | 29.99 | True      | Home     |

  Scenario: Create a Product
    When I set the "Name" to "Shirt"
    And I set the "Description" to "A nice cotton shirt"
    And I set the "Price" to "29.99"
    And I select "True" in the "Available" dropdown
    And I select "Cloths" in the "Category" dropdown
    And I press the "Create" button
    Then I should see the message "Product created!"

  Scenario: Read a Product
    When I set the "Name" to "Hat"
    And I press the "Search" button
    Then I should see the message "Success"
    And I should see "Hat" in the "Name" field
    And I should see "A red fedora" in the "Description" field

  Scenario: Update a Product
    When I set the "Name" to "Hat"
    And I press the "Search" button
    Then I should see the message "Success"
    When I change "Name" to "Fedora"
    And I press the "Update" button
    Then I should see the message "Success"
    And I should see "Fedora" in the "Name" field

  Scenario: Delete a Product
    When I set the "Name" to "Hat"
    And I press the "Search" button
    Then I should see the message "Success"
    When I press the "Delete" button
    Then I should see the message "Product has been Deleted!"
    
  Scenario: List all products
    When I press the "Search" button
    Then I should see the message "Success"
    And I should see "Hat" in the results
    And I should see "Shoes" in the results
    And I should see "Big Mac" in the results
    And I should see "Sheets" in the results

  Scenario: Search by category
    When I select "Food" in the "Category" dropdown
    And I press the "Search" button
    Then I should see the message "Success"
    And I should see "Big Mac" in the results
    And I should not see "Hat" in the results
    And I should not see "Shoes" in the results
    And I should not see "Sheets" in the results

  Scenario: Search by available
    When I select "True" in the "Available" dropdown
    And I press the "Search" button
    Then I should see the message "Success"
    And I should see "Hat" in the results
    And I should see "Big Mac" in the results
    And I should see "Sheets" in the results
    And I should not see "Shoes" in the results

  Scenario: Search by name
    When I set the "Name" to "Hat"
    And I press the "Search" button
    Then I should see the message "Success"
    And I should see "Hat" in the "Name" field
    And I should see "A red fedora" in the "Description" field
