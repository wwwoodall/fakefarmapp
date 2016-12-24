require "test_helper"

class CanCrudTicketsTest < Capybara::Rails::TestCase
  feature 'User successfully creates new ticket' do
    scenario 'starting at root path' do

      # from the homepage
      visit root_path
      click_link 'tickets'
      assert_content page, 'tickets'

      # from tickets, click new
      click_link 'new ticket'
      assert_equal current_path, new_ticket_path

      # from new, fill in form
      ticket = tickets(:one)
      page.fill_in 'Title', :with => ticket.title
      click_button 'Create Ticket'

      # expect to be directed to tickets
      assert_equal current_path, tickets_path
      assert_content page, 'tickets'
      assert_content page, ticket.title
      within('.notice') do
        assert page.has_content?(ticket.title)
      end
    end
  end

  feature 'User updates an existing ticket' do
    scenario 'add ticket details' do
      @ticket = tickets(:one) 
      visit root_path
     
      # click on ticket title
      click_link 'tickets'
      click_link @ticket.title
      assert_content page, @ticket.title

      # fill in edit page with rest of contents
      page.fill_in 'Ticket', with: @ticket.ticket
      page.fill_in 'Summary', with: @ticket.summary
      page.fill_in 'Merge', with: @ticket.merge
      page.fill_in 'Date due', with: 2.weeks.from_now 
      page.fill_in 'Date started', with: 3.days.ago 
      # save
      click_button 'Update'

      # returned to index
      assert_equal current_path, tickets_path
      within('.notice') do
        assert page.has_content?('ticket updated')
      end
    end
  end


    # can be viewed from root
    # can be read from index
    # can be created from index
    # can be read from show page
    # can be edited from show
    # can be deleted from show

end