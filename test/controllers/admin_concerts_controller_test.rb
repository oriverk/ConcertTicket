require 'test_helper'

class AdminConcertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_concert = admin_concerts(:one)
  end

  test 'should get index' do
    get admin_concerts_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_concert_url
    assert_response :success
  end

  test 'should create admin_concert' do
    assert_difference('AdminConcert.count') do
      post admin_concerts_url, params: { admin_concert: {} }
    end

    assert_redirected_to admin_concert_url(AdminConcert.last)
  end

  test 'should show admin_concert' do
    get admin_concert_url(@admin_concert)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_concert_url(@admin_concert)
    assert_response :success
  end

  test 'should update admin_concert' do
    patch admin_concert_url(@admin_concert), params: { admin_concert: {} }
    assert_redirected_to admin_concert_url(@admin_concert)
  end

  test 'should destroy admin_concert' do
    assert_difference('AdminConcert.count', -1) do
      delete admin_concert_url(@admin_concert)
    end

    assert_redirected_to admin_concerts_url
  end
end
