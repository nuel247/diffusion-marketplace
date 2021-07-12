require 'rails_helper'

describe 'Admin Dashboard Categories Tab', type: :feature do
  before do
    @admin = User.create!(email: 'sandy.cheeks@va.gov', password: 'Password123',
                          password_confirmation: 'Password123', skip_va_validation: true, confirmed_at: Time.now, accepted_terms: true)
    @admin.add_role(:admin)

    @cat_1 = Category.create!(name: 'First Parent Category', is_other: false)
    @cat_2 = Category.create!(name: 'Second Parent Category', is_other: false)
    @cat_3 = Category.create!(name: 'First Category', is_other: false, parent_category: @cat_1)
    @cat_4 = Category.create!(name: 'Second Category', is_other: false, parent_category: @cat_1)
    @cat_5 = Category.create!(name: 'Third Category', is_other: false, parent_category: @cat_2)
    @cat_6 = Category.create!(name: 'Fourth Category', is_other: false, parent_category: @cat_2)

    login_as(@admin, scope: :user, run_callbacks: false)
  end

  it 'should allow the user to create a category' do
    visit '/admin/categories'

    # since the category being created does not have any subcategories, the 'Parent category' select element should show up
    click_link('New Category')
    expect(page).to have_selector('#category_parent_category_id')

    fill_in('Name', with: 'Fifth Category')
    select('Second Parent Category', :from => 'category_parent_category_id')
    click_button('Create Category')

    expect(page).to have_content('Category was successfully created.')
  end

  it 'should allow the user to update a category' do
    visit '/admin/categories'

    # if the category being updated does not have any subcategories, the 'Parent category' select element should show up
    all('.edit_link').first.click
    expect(page).to have_selector('#category_parent_category_id')

    # if the category being updated does have subcategories, the 'Parent category' select element should not show up
    find('#categories').click

    all('.edit_link').last.click
    expect(page).to_not have_selector('#category_parent_category_id')

    fill_in('Name', with: 'Parent Category Three')
    click_button('Update Category')

    expect(page).to have_content('Category was successfully updated.')
  end
end