require 'rails_helper'

describe 'VISN pages', type: :feature do
  before do
    ENV['GOOGLE_API_KEY'] = ENV['GOOGLE_TEST_API_KEY']

    @visn = Visn.create!(
      name: 'Test VISN',
      number: 1,
      street_address: "111 Test Street",
      city: "Dallas",
      state: "TX",
      zip_code: "75211",
      latitude: "32.880578",
      longitude: "-96.754906",
      phone_number: "111-000-0000"
    )
    @visn_2 = Visn.create!(
      name: 'Test VISN',
      number: 2,
      street_address: "100 Test Avenue",
      city: "Tampa",
      state: "FL",
      zip_code: "33728",
      latitude: "28.063901",
      longitude: "-82.466679",
      phone_number: "111-111-1111"
    )

    @visn_liaison = VisnLiaison.create!(
      visn: @visn,
      first_name: 'Megumi',
      last_name: 'Fushiguro',
      email: 'megumi.fushiguro@va.gov',
      primary: true
    )

    @visn_liaison_2 = VisnLiaison.create!(
      visn: @visn_2,
      first_name: 'Toge',
      last_name: 'Inumaki',
      email: 'toge.inumaki@va.gov',
      primary: true
    )

    @va_facility = VaFacility.create!(
      visn: @visn,
      sta3n: 421,
      station_number: 421,
      official_station_name: 'Test Name',
      common_name: 'Test Common Name',
      classification: 'VA Medical Center (VAMC)',
      classification_status: 'Firm',
      mobile: 'No',
      parent_station_number: 414,
      official_parent_station_name: 'Test station',
      fy17_parent_station_complexity_level: '1c-High Complexity',
      operational_status: 'A',
      ownership_type: 'VA Owned Asset',
      delivery_mechanism: nil,
      staffing_type: 'VA Staff Only',
      va_secretary_10n_approved_date: '-12324',
      planned_activation_date: '-12684',
      station_number_suffix_reservation_effective_date: '05/23/1995',
      operational_date: '-14321',
      date_of_first_workload: 'Pre-FY2000',
      points_of_service: 2,
      street_address: '1 Test Ave',
      street_address_city: 'Las Vegas',
      street_address_state: 'NV',
      street_address_zip_code: '11111',
      street_address_zip_code_extension: '1111',
      county_street_address: 'Test',
      mailing_address: '1 Test Ave',
      mailing_address_city: 'Las Vegas',
      mailing_address_state: 'NV',
      mailing_address_zip_code: '11111',
      mailing_address_zip_code_extension: '1111',
      county_mailing_address: 'Test',
      station_phone_number: '207-623-8411',
      station_main_fax_number: '207-623-8412',
      after_hours_phone_number: '207-623-7211',
      pharmacy_phone_number: '286-322-1342',
      enrollment_coordinator_phone_number: '207-623-9332',
      patient_advocate_phone_number: '207-623-1122',
      latitude: '44.03409934',
      longitude: '-70.70545322',
      congressional_district: 'CD116_ME_23001',
      market: '01-b',
      sub_market: '01-b-9',
      sector: '01-b-10-A',
      fips_code: '23022',
      rurality: 'U',
      monday: '24/7',
      tuesday: '24/7',
      wednesday: '24/7',
      thursday: '24/7',
      friday: '24/7',
      saturday: '24/7',
      sunday: '24/7',
      hours_note: 'This is a test'
    )
    @va_facility_2 = VaFacility.create!(
      visn: @visn_2,
      sta3n: 454,
      station_number: 424,
      official_station_name: 'Second Test Name',
      common_name: 'Second Test Common Name',
      classification: 'VA Medical Center (VAMC)',
      classification_status: 'Firm',
      mobile: 'Yes',
      parent_station_number: 454,
      official_parent_station_name: 'Second test station',
      fy17_parent_station_complexity_level: '1c-High Complexity',
      operational_status: 'A',
      ownership_type: 'VA Owned Asset',
      delivery_mechanism: nil,
      staffing_type: 'VA Staff Only',
      va_secretary_10n_approved_date: '-12324',
      planned_activation_date: '-12684',
      station_number_suffix_reservation_effective_date: '01/27/1991',
      operational_date: '-14321',
      date_of_first_workload: 'Pre-FY2000',
      points_of_service: 2,
      street_address: '1 Test St',
      street_address_city: 'Tampa',
      street_address_state: 'FL',
      street_address_zip_code: '11111',
      street_address_zip_code_extension: '1111',
      county_street_address: 'Test 2',
      mailing_address: '1 Test St',
      mailing_address_city: 'Tampa',
      mailing_address_state: 'FL',
      mailing_address_zip_code: '11111',
      mailing_address_zip_code_extension: '1111',
      county_mailing_address: 'Test',
      station_phone_number: '207-623-8411',
      station_main_fax_number: '207-623-8412',
      after_hours_phone_number: '207-623-7211',
      pharmacy_phone_number: '286-322-1342',
      enrollment_coordinator_phone_number: '207-623-9332',
      patient_advocate_phone_number: '207-623-1122',
      latitude: '44.03409934',
      longitude: '-70.70545322',
      congressional_district: 'CD116_ME_23001',
      market: '01-b',
      sub_market: '01-b-9',
      sector: '01-b-10-A',
      fips_code: '23022',
      rurality: 'U',
      monday: '24/7',
      tuesday: '24/7',
      wednesday: '24/7',
      thursday: '24/7',
      friday: '24/7',
      saturday: '-',
      sunday: '-',
      hours_note: 'This is a second test'
    )
    @va_facility_3 = VaFacility.create!(
      visn: @visn_2,
      sta3n: 454,
      station_number: 443,
      official_station_name: 'Third Test Name',
      common_name: 'Third Test Common Name',
      classification: 'Primary Care CBOC',
      classification_status: 'Firm',
      mobile: 'Yes',
      parent_station_number: 454,
      official_parent_station_name: 'Third test station',
      fy17_parent_station_complexity_level: '1c-High Complexity',
      operational_status: 'A',
      ownership_type: 'VA Owned Asset',
      delivery_mechanism: nil,
      staffing_type: 'VA Staff Only',
      va_secretary_10n_approved_date: '-12324',
      planned_activation_date: '-12684',
      station_number_suffix_reservation_effective_date: '01/27/1991',
      operational_date: '-14321',
      date_of_first_workload: 'Pre-FY2000',
      points_of_service: 2,
      street_address: '1 Test Ln',
      street_address_city: 'Clearwater',
      street_address_state: 'FL',
      street_address_zip_code: '11111',
      street_address_zip_code_extension: '1111',
      county_street_address: 'Test 2',
      mailing_address: '1 Test Ln',
      mailing_address_city: 'Clearwater',
      mailing_address_state: 'FL',
      mailing_address_zip_code: '11111',
      mailing_address_zip_code_extension: '1111',
      county_mailing_address: 'Test',
      station_phone_number: '207-623-8411',
      station_main_fax_number: '207-623-8412',
      after_hours_phone_number: '207-623-7211',
      pharmacy_phone_number: '286-322-1342',
      enrollment_coordinator_phone_number: '207-623-9332',
      patient_advocate_phone_number: '207-623-1122',
      latitude: '27.96636756',
      longitude: '-82.79163245',
      congressional_district: 'CD116_ME_23001',
      market: '01-b',
      sub_market: '01-b-9',
      sector: '01-b-10-A',
      fips_code: '23022',
      rurality: 'U',
      monday: '24/7',
      tuesday: '24/7',
      wednesday: '24/7',
      thursday: '24/7',
      friday: '24/7',
      saturday: '-',
      sunday: '-',
      hours_note: 'This is a third test'
    )
    @va_facility_4 = VaFacility.create!(
      visn: @visn_2,
      sta3n: 454,
      station_number: 431,
      official_station_name: 'Fourth Test Name',
      common_name: 'Fourth Common Name',
      classification: 'Residential Care Site (MH RRTP/DRRTP) (Stand-Alone)',
      classification_status: 'Firm',
      mobile: 'Yes',
      parent_station_number: 454,
      official_parent_station_name: 'Fourth test station',
      fy17_parent_station_complexity_level: '1c-High Complexity',
      operational_status: 'A',
      ownership_type: 'VA Owned Asset',
      delivery_mechanism: nil,
      staffing_type: 'VA Staff Only',
      va_secretary_10n_approved_date: '-12324',
      planned_activation_date: '-12684',
      station_number_suffix_reservation_effective_date: '01/27/1991',
      operational_date: '-14321',
      date_of_first_workload: 'Pre-FY2000',
      points_of_service: 2,
      street_address: '1 Test Circle',
      street_address_city: 'Warner Robins',
      street_address_state: 'GA',
      street_address_zip_code: '22222',
      street_address_zip_code_extension: '2222',
      county_street_address: 'Test 2',
      mailing_address: '1 Test Circle',
      mailing_address_city: 'Warner Robins',
      mailing_address_state: 'GA',
      mailing_address_zip_code: '22222',
      mailing_address_zip_code_extension: '2222',
      county_mailing_address: 'Test',
      station_phone_number: '207-623-8411',
      station_main_fax_number: '207-623-8412',
      after_hours_phone_number: '207-623-7211',
      pharmacy_phone_number: '286-322-1342',
      enrollment_coordinator_phone_number: '207-623-9332',
      patient_advocate_phone_number: '207-623-1122',
      latitude: '32.60681842',
      longitude: '-83.64688667',
      congressional_district: 'CD116_ME_23001',
      market: '01-b',
      sub_market: '01-b-9',
      sector: '01-b-10-A',
      fips_code: '23022',
      rurality: 'U',
      monday: '24/7',
      tuesday: '24/7',
      wednesday: '24/7',
      thursday: '24/7',
      friday: '24/7',
      saturday: '-',
      sunday: '-',
      hours_note: 'This is a fourth test'
    )

    @user = User.create!(email: 'nobara.kugisaki@va.gov', password: 'Password123', password_confirmation: 'Password123', skip_va_validation: true, confirmed_at: Time.now)

    @practice = Practice.create!(name: 'The Best Practice Ever!', initiating_facility_type: 'facility', tagline: 'Test tagline', date_initiated: 'Sun, 05 Feb 1992 00:00:00 UTC +00:00', summary: 'This is the best practice ever.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice, facility_type: 0, facility_id: '421')
    @practice_2 = Practice.create!(name: 'An Awesome Practice!', initiating_facility_type: 'visn', initiating_facility: '2', tagline: 'Test tagline 2', date_initiated: 'Sun, 24 Oct 2004 00:00:00 UTC +00:00', summary: 'This is an awesome practice.', published: true, enabled: true, approved: true, user: @user)
    @practice_3 = Practice.create!(name: 'A Very Cool Practice!', initiating_facility_type: 'facility', tagline: 'Super cool tagline', date_initiated: 'Mon, 09 Mar 1999 00:00:00 UTC +00:00', summary: 'This is a very cool practice.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice_3, facility_type: 0, facility_id: '443')
    @practice_4 = Practice.create!(name: 'A Fantastic Practice!', initiating_facility_type: 'facility', tagline: 'Cool tagline', date_initiated: 'Fri, 21 Oct 2001 00:00:00 UTC +00:00', summary: 'This is a fantastic practice.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice_4, facility_type: 0, facility_id: '424')
    @practice_5 = Practice.create!(name: 'A Magnificent Practice!', initiating_facility_type: 'facility', tagline: 'Test tagline 5', date_initiated: 'Sat, 30 Nov 1995 00:00:00 UTC +00:00', summary: 'This is a magnificent practice.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice_5, facility_type: 0, facility_id: '424')
    @practice_6 = Practice.create!(name: 'A Spectacular Practice!', initiating_facility_type: 'visn', initiating_facility: '2', tagline: 'Test tagline 6', date_initiated: 'Sun, 09 Oct 2008 00:00:00 UTC +00:00', summary: 'This is a spectacular practice.', published: true, enabled: true, approved: true, user: @user)
    @practice_7 = Practice.create!(name: 'A Meaningful Practice!', initiating_facility_type: 'facility', tagline: 'Test tagline 7', date_initiated: 'Wed, 11 Feb 1991 00:00:00 UTC +00:00', summary: 'This is a meaningful practice.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice_7, facility_type: 0, facility_id: '443')
    @practice_8 = Practice.create!(name: 'A Ground-breaking Practice!', initiating_facility_type: 'facility', tagline: 'Test tagline 8', date_initiated: 'Thu, 15 Feb 2015 00:00:00 UTC +00:00', summary: 'This is a ground-breaking practice.', overview_problem: 'overview-problem', published: true, enabled: true, approved: true, user: @user)
    PracticeOriginFacility.create!(practice: @practice_8, facility_type: 0, facility_id: '424')

    @dh = DiffusionHistory.create!(practice_id: @practice.id, facility_id: '443')
    DiffusionHistoryStatus.create!(diffusion_history: @dh, status: 'Completed', start_time: Time.now)
    @dh_2 = DiffusionHistory.create!(practice_id: @practice_2.id, facility_id: '431')
    DiffusionHistoryStatus.create!(diffusion_history: @dh_2, status: 'Completed', start_time: Time.now)
    @dh_3 = DiffusionHistory.create!(practice_id: @practice_3.id, facility_id: '443')
    DiffusionHistoryStatus.create!(diffusion_history: @dh_3, status: 'Completed', start_time: Time.now)

    @cat_1 = Category.create!(name: 'COVID')
    @cat_2 = Category.create!(name: 'Test Cat')
    CategoryPractice.create!(practice: @practice_3, category: @cat_1, created_at: Time.now)
    CategoryPractice.create!(practice: @practice_4, category: @cat_2, created_at: Time.now)
  end

  after do
    ENV['GOOGLE_API_KEY'] = nil
  end

  def expect_visn_metadata(element, practices_created_count_text, practices_adopted_count_text)
    within(:css, element) do
      expect(find('.visn-practice-creations-count').text).to eq(practices_created_count_text)
      expect(find('.visn-adoptions-count').text).to eq(practices_adopted_count_text)
    end
  end

  describe 'index page' do
    before do
      visit '/visns'
    end

    it 'should be there' do
      expect(page).to have_current_path(visns_path)
    end

    describe 'visns index map' do
      before do
        @visn_marker_div = 'div[style*="width: 48px"][title=""]'
        @visn_markers = find_all(:css, @visn_marker_div)
      end

      it 'should be there with the correct amount of markers' do
        expect(page).to have_selector('#visns-index-map', visible: true)
        expect(@visn_markers.count).to eq(2)
      end

      it 'should show metadata for each visn' do
        @visn_markers.last.click
        expect(page).to have_selector('#visn-2-marker-modal', visible: true)
        expect_visn_metadata('#visn-2-marker-modal', '7 practices created here', '3 practices adopted here')
      end

      it 'should have a link to a given visn\'s show page within that visn\'s marker modal' do
        @visn_markers.last.click
        expect(page).to have_selector('#visn-2-marker-modal', visible: true)

        within(:css, '#visn-2-marker-modal') do
          expect(find('.visn-modal-link')[:href]).to include('/visns/2')
        end
      end
    end

    describe 'visn cards' do
      before do
        @visn_cards = find_all(:css, '.dm-visn-card')
      end

      it 'should show a card for every visn' do
        expect(@visn_cards.count).to eq(2)
      end

      it 'should show metadata for each visn' do
        expect_visn_metadata('#visn-1-card-link', '1 practice created here', '0 practices adopted here')
      end

      it 'should allow the user to visit a visn\'s show page via clicking on a visn card' do
        @visn_cards.first.click

        expect(page).to have_content('1')
        expect(page).to have_current_path(visn_path(@visn))
      end
    end
  end

  describe 'show page' do
    it 'should be there if the VISN number exists in the DB' do
      visit '/visns/1'

      expect(page).to have_current_path(visn_path(@visn))
    end

    it 'should display a brief breakdown of the visn\'s metadata' do
      visit '/visns/2'

      expect(page).to have_content('This VISN has 3 facilities and serves Veterans in Florida and Georgia.')
      expect(page).to have_content('Collectively, its facilities have created 7 practices and have adopted 3 practices.')
      expect(page).to have_content('Toge Inumaki')
    end

    describe 'visns show map' do
      it 'should be there with the correct amount of markers (defaulted to VAMC facilities on initial load)' do
        visit '/visns/2'

        expect(find_all(:css, 'div[style*="width: 34px"][title=""]').count).to eq(1)
      end

      it 'should show facility markers based on which facility type filters are selected' do
        visit '/visns/2'
        facility_type_labels = find_all('.facility-type-checkbox-label')

        # make sure the filter count is based on which facility types belong to the VISN
        expect(facility_type_labels.count).to eq(3)
        # make sure labels are in alphabetical order except for the first one, which should be VAMC
        expect(facility_type_labels.first.text).to eq('VA Medical Center (VAMC)')
        expect(facility_type_labels[1].text).to eq('Primary Care CBOC')
        expect(facility_type_labels.last.text).to eq('Residential Care Site (MH RRTP/DRRTP) (Stand-Alone)')
        # add each filter and make sure the visible facility markers update
        facility_type_labels[1].click
        expect(find_all(:css, 'div[style*="width: 34px"][title=""]').count).to eq(2)

        facility_type_labels.last.click
        expect(find_all(:css, 'div[style*="width: 34px"][title=""]').count).to eq(3)
        # now remove all filters and make sure the total facility marker count is correct
        facility_type_labels.first.click
        facility_type_labels[1].click
        facility_type_labels.last.click
        expect(find_all(:css, 'div[style*="width: 34px"][title=""]').count).to eq(3)
      end

      it 'should show metadata for each facility' do
        visit '/visns/1'
        find_all(:css, 'div[style*="width: 34px"][title=""]').first.click
        expect(page).to have_selector('#visn-va-facility-1-marker-modal', visible: true)
        within(:css, '#visn-va-facility-1-marker-modal') do
          expect(find('.visn-va-facility-marker-modal-link').text).to eq('Test Name (Test Common Name)')
          expect(find('.visn-va-facility-modal-practices-created-count').text).to eq('1 practice created here')
          expect(find('.visn-va-facility-modal-practices-adopted-count').text).to eq('0 practices adopted here')
        end
      end

      it 'should have a link to a given facility\'s show page within that facility\'s marker modal' do
        visit '/visns/1'
        find_all(:css, 'div[style*="width: 34px"][title=""]').first.click
        expect(page).to have_selector('#visn-va-facility-1-marker-modal', visible: true)

        within(:css, '#visn-va-facility-1-marker-modal') do
          expect(find('.visn-va-facility-marker-modal-link')[:href]).to include('/facilities/test-common-name')
        end
      end
    end

    def practice_cards
      find_all('.dm-practice-card', visible: true)
    end

    describe 'visn search section' do
      it 'should allow users to search for practices that were created or adopted within a given visn' do
        visit '/visns/2'

        # defaults to created practices
        # make sure 'Load more' feature is working
        expect(practice_cards.count).to eq(6)
        click_button('Load more')
        expect(practice_cards.count).to eq(7)

        # switch to adopted practices
        find_all('.usa-radio__label').last.click
        expect(practice_cards.count).to eq(3)

        # run the search on created practices
        find_all('.usa-radio__label').first.click
        fill_in('visn-search-field', with: 'cool')
        find('#visn-search-button').click

        expect(practice_cards.count).to eq(2)

        # now sort by A to Z
        expect(all('h3.dm-practice-title').first.text).to eq(@practice_3.name)
        select('Sort by A to Z', from: 'search_sort_option')

        expect(all('h3.dm-practice-title').first.text).to eq(@practice_4.name)

        # now filter the results by category
        find_all('.usa-combo-box__input')[0].click
        find_all('.usa-combo-box__input')[0].set('COVID')
        find_all('.usa-combo-box__list-option').first.click

        expect(practice_cards.count).to eq(1)
      end

      it 'should allow users to visit a visns\'s show page with a search query' do
        visit '/visns/2?query=cool'

        expect(practice_cards.count).to eq(2)
      end
    end

    describe 'facilities table' do
      it 'should display a modal when the user clicks on the question mark icon next to the complexity column in the facilities table' do
        visit '/visns/1'
        find('.fa-question-circle').click

        expect(page).to have_content('1a-Highest complexity')
        expect(page).to have_content('Facilities with high volume, high risk patients, most complex clinical programs, and large research and teaching programs')

        # check to make sure it closes properly
        find('.usa-modal__close').click

        expect(page).to_not have_content('1a-Highest complexity')
      end

      it 'should take the user to the show page of the facility they click on within the facilities table' do
        visit '/visns/2'
        click_link('Fourth Test Name (Fourth Common Name)')
        expect(page).to have_selector('#va_facility_map', visible: true)
        expect(page).to have_current_path('/facilities/fourth-common-name')
      end
    end
  end
end