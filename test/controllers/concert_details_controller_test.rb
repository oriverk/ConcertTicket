# frozen_string_literal: true

require 'test_helper'

class ConcertDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @concert_detail = concert_details(:one)
  end

  test 'should get index' do
    get concert_details_url
    assert_response :success
  end

  test 'should get new' do
    get new_concert_detail_url
    assert_response :success
  end

  test 'should create concert_detail' do
    assert_difference('ConcertDetail.count') do
      post concert_details_url, params: { concert_detail: { capacity: @concert_detail.capacity, concert_id: @concert_detail.concert_id, grade: @concert_detail.grade, price: @concert_detail.price } }
    end

    assert_redirected_to concert_detail_url(ConcertDetail.last)
  end

  test 'should show concert_detail' do
    get concert_detail_url(@concert_detail)
    assert_response :success
  end

  test 'should get edit' do
    get edit_concert_detail_url(@concert_detail)
    assert_response :success
  end

  test 'should update concert_detail' do
    patch concert_detail_url(@concert_detail), params: { concert_detail: { capacity: @concert_detail.capacity, concert_id: @concert_detail.concert_id, grade: @concert_detail.grade, price: @concert_detail.price } }
    assert_redirected_to concert_detail_url(@concert_detail)
  end

  test 'should destroy concert_detail' do
    assert_difference('ConcertDetail.count', -1) do
      delete concert_detail_url(@concert_detail)
    end

    assert_redirected_to concert_details_url
  end
end
