require 'rails_helper'

describe "the edit a task process" do
  it "edits a task" do
    list = List.create(:name => 'Home stuff')
    task = Task.create(:description => 'Wash the dishes', :list_id => list.id)
    visit edit_list_task_path(list, task)
    fill_in 'Description', :with => 'Wash the dog'
    click_on 'Update Task'
    expect(page).to have_content 'successfully'
  end

  it "gives error when no description is entered" do
    list = List.create(:name => 'Home stuff')
    task = Task.create(:description => 'Wash the dishes', :list_id => list.id)
    visit edit_list_task_path(list, task)
    fill_in 'Description', :with => ''
    click_on 'Update Task'
    expect(page).to have_content 'errors'
  end

  it "should add a new task to the list using AJAX", js: true do
    list = List.create(:name => 'Home stuff')
    visit lists_path(list)
    click_on "Home stuff"
    click_on "Add a task"
    fill_in "Description", :with => "New description for task"
    click_button "Create Task"
    page.should have_content("New description for task")
  end
end
