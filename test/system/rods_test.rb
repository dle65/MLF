require "application_system_test_case"

class RodsTest < ApplicationSystemTestCase
  setup do
    @rod = rods(:one)
  end

  test "visiting the index" do
    visit rods_url
    assert_selector "h1", text: "Rods"
  end

  test "creating a Rod" do
    visit rods_url
    click_on "New Rod"

    fill_in "Brand", with: @rod.brand
    fill_in "Color", with: @rod.color
    fill_in "Description", with: @rod.description
    fill_in "Price", with: @rod.price
    fill_in "Size", with: @rod.size
    fill_in "Stock quantity", with: @rod.stock_quantity
    fill_in "Title", with: @rod.title
    click_on "Create Rod"

    assert_text "Rod was successfully created"
    click_on "Back"
  end

  test "updating a Rod" do
    visit rods_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @rod.brand
    fill_in "Color", with: @rod.color
    fill_in "Description", with: @rod.description
    fill_in "Price", with: @rod.price
    fill_in "Size", with: @rod.size
    fill_in "Stock quantity", with: @rod.stock_quantity
    fill_in "Title", with: @rod.title
    click_on "Update Rod"

    assert_text "Rod was successfully updated"
    click_on "Back"
  end

  test "destroying a Rod" do
    visit rods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rod was successfully destroyed"
  end
end
