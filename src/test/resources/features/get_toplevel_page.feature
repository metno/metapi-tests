Feature: Get toplevel page

  @get_toplevel_page
  Scenario: Get toplevel page
    Given n/a
    When I make an HTTP GET request for /
    Then I should get a response with status code = 200 and body containing 'API Overview'
