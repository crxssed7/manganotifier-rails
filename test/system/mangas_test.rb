require "application_system_test_case"

class MangasTest < ApplicationSystemTestCase
  setup do
    @manga = mangas(:one)
  end

  test "visiting the index" do
    visit mangas_url
    assert_selector "h1", text: "Mangas"
  end

  test "should create manga" do
    visit mangas_url
    click_on "New manga"

    fill_in "External", with: @manga.external_id
    fill_in "Image", with: @manga.image
    fill_in "Last chapter", with: @manga.last_chapter
    fill_in "Last refreshed", with: @manga.last_refreshed
    fill_in "Name", with: @manga.name
    fill_in "Source", with: @manga.source
    click_on "Create Manga"

    assert_text "Manga was successfully created"
    click_on "Back"
  end

  test "should update Manga" do
    visit manga_url(@manga)
    click_on "Edit this manga", match: :first

    fill_in "External", with: @manga.external_id
    fill_in "Image", with: @manga.image
    fill_in "Last chapter", with: @manga.last_chapter
    fill_in "Last refreshed", with: @manga.last_refreshed
    fill_in "Name", with: @manga.name
    fill_in "Source", with: @manga.source
    click_on "Update Manga"

    assert_text "Manga was successfully updated"
    click_on "Back"
  end

  test "should destroy Manga" do
    visit manga_url(@manga)
    click_on "Destroy this manga", match: :first

    assert_text "Manga was successfully destroyed"
  end
end
