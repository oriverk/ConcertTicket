# frozen_string_literal: true

require 'application_system_test_case'

class ConcertDetailsTest < ApplicationSystemTestCase
  setup do
    @concert_detail = concert_details(:one)
  end

  test 'visiting the index' do
    visit concert_details_url
    assert_selector 'h1', text: 'Concert Details'
  end

  test 'creating a Concert detail' do
    visit concert_details_url
    click_on 'New Concert Detail'

    fill_in 'Capacity', with: @concert_detail.capacity
    fill_in 'Concert', with: @concert_detail.concert_id
    fill_in 'Grade', with: @concert_detail.grade
    fill_in 'Price', with: @concert_detail.price
    click_on 'Create Concert detail'

    assert_text 'Concert detail was successfully created'
    click_on 'Back'
  end

  test 'updating a Concert detail' do
    visit concert_details_url
    click_on 'Edit', match: :first

    fill_in 'Capacity', with: @concert_detail.capacity
    fill_in 'Concert', with: @concert_detail.concert_id
    fill_in 'Grade', with: @concert_detail.grade
    fill_in 'Price', with: @concert_detail.price
    click_on 'Update Concert detail'

    assert_text 'Concert detail was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Concert detail' do
    visit concert_details_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Concert detail was successfully destroyed'
  end
end
