require "application_system_test_case"

class AdminConcertsTest < ApplicationSystemTestCase
  setup do
    @admin_concert = admin_concerts(:one)
  end

  test "visiting the index" do
    visit admin_concerts_url
    assert_selector "h1", text: "Admin Concerts"
  end

  test "creating a Admin concert" do
    visit admin_concerts_url
    click_on "New Admin Concert"

    click_on "Create Admin concert"

    assert_text "Admin concert was successfully created"
    click_on "Back"
  end

  test "updating a Admin concert" do
    visit admin_concerts_url
    click_on "Edit", match: :first

    click_on "Update Admin concert"

    assert_text "Admin concert was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin concert" do
    visit admin_concerts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin concert was successfully destroyed"
  end
end
