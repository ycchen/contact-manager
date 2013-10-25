require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { business_city: @contact.business_city, business_fax: @contact.business_fax, business_phone2: @contact.business_phone2, business_phone: @contact.business_phone, business_state: @contact.business_state, business_street: @contact.business_street, business_zipcode: @contact.business_zipcode, company: @contact.company, company_phone: @contact.company_phone, department: @contact.department, email: @contact.email, first_name: @contact.first_name, home_phone: @contact.home_phone, job_title: @contact.job_title, last_name: @contact.last_name, middle_name: @contact.middle_name, mobile_phone: @contact.mobile_phone, other_phone: @contact.other_phone, suffix: @contact.suffix, website: @contact.website }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, contact: { business_city: @contact.business_city, business_fax: @contact.business_fax, business_phone2: @contact.business_phone2, business_phone: @contact.business_phone, business_state: @contact.business_state, business_street: @contact.business_street, business_zipcode: @contact.business_zipcode, company: @contact.company, company_phone: @contact.company_phone, department: @contact.department, email: @contact.email, first_name: @contact.first_name, home_phone: @contact.home_phone, job_title: @contact.job_title, last_name: @contact.last_name, middle_name: @contact.middle_name, mobile_phone: @contact.mobile_phone, other_phone: @contact.other_phone, suffix: @contact.suffix, website: @contact.website }
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
