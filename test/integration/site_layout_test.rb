require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
  end

  test 'full title for home page' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'title', full_title
  end

  test 'full title for help page' do
    get help_path
    assert_template 'static_pages/help'
    assert_select 'title', full_title('help')
  end

  test 'full title for help about' do
    get about_path
    assert_template 'static_pages/about'
    assert_select 'title', full_title('about')
  end

  test 'full title for contact page' do
    get contact_path
    assert_template 'static_pages/contact'
    assert_select 'title', full_title('contact')
  end
end
