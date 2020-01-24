require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  setup do
    @link = links(:one)
  end

  test "visiting the index" do
    visit links_url
    assert_selector "h1", text: "Links"
  end

  test "creating a Link" do
    visit links_url
    click_on "New Link"

    fill_in "Isenabled", with: @link.isEnabled
    fill_in "Ishighlight", with: @link.isHighlight
    fill_in "Order", with: @link.order
    fill_in "Title", with: @link.title
    fill_in "Url", with: @link.url
    fill_in "User", with: @link.user_id
    fill_in "Uuid", with: @link.uuid
    click_on "Create Link"

    assert_text "Link was successfully created"
    click_on "Back"
  end

  test "updating a Link" do
    visit links_url
    click_on "Edit", match: :first

    fill_in "Isenabled", with: @link.isEnabled
    fill_in "Ishighlight", with: @link.isHighlight
    fill_in "Order", with: @link.order
    fill_in "Title", with: @link.title
    fill_in "Url", with: @link.url
    fill_in "User", with: @link.user_id
    fill_in "Uuid", with: @link.uuid
    click_on "Update Link"

    assert_text "Link was successfully updated"
    click_on "Back"
  end

  test "destroying a Link" do
    visit links_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Link was successfully destroyed"
  end
end
