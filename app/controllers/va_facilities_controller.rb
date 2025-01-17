class VaFacilitiesController < ApplicationController
  include PracticeUtils, VaFacilitiesHelper
  before_action :set_va_facility, only: [:show, :created_practices, :update_practices_adopted_at_facility]
  def index
    va_facilities = VaFacility.cached_va_facilities.select(:common_name, :id, :visn_id, :official_station_name).order_by_station_name.includes([:visn])
    clinical_resource_hubs = ClinicalResourceHub.cached_clinical_resource_hubs
    @facilities = (va_facilities.includes(:visn).sort_by(&:official_station_name.downcase) + clinical_resource_hubs.includes([:visn]).sort_by(&:id))
    @visns = Visn.cached_visns.select(:name, :number)
    @types = VaFacility.cached_va_facilities.order_by_station_name.get_complexity
  end

  def load_facilities_index_rows
    if params[:facility].present?
      @facilities = [VaFacility.cached_va_facilities.order_by_station_name.includes([:visn]).find(params[:facility])]

    elsif params[:crh].present?
      @facilities = [ClinicalResourceHub.find_by_id(params[:crh].to_i)]
    else
      @facilities = VaFacility.cached_va_facilities.order_by_station_name.includes([:visn]).get_relevant_attributes
      @clinical_resource_hubs = ClinicalResourceHub.cached_clinical_resource_hubs

      if params[:visn].present?
        @facilities = @facilities.where(visns: { number: params[:visn] })
        visn_id = Visn.where(number: params["visn"].to_i).first().id
        @clinical_resource_hubs = @clinical_resource_hubs.where(visn_id: visn_id)
      end
      if params[:complexity].present?
        @clinical_resource_hubs = []
        @facilities = @facilities.where(va_facilities: { fy17_parent_station_complexity_level: params[:complexity] })
      end
      @facilities += @clinical_resource_hubs
    end
    table_rows_html = render_to_string('va_facilities/_index_table_row', layout: false, locals: { facilities: @facilities })
    respond_to do |format|
      format.html
      format.json { render :json => { rowsHtml: table_rows_html, count: @facilities.length } }
    end
  end

  def show
    station_number = @va_facility.station_number
    # google maps implementation
    @va_facility_marker = Gmaps4rails.build_markers(@va_facility) do |facility, marker|
      marker.lat facility.latitude
      marker.lng facility.longitude
      marker.picture({
                         url: view_context.image_path('visn-va-facility-map-marker-default.svg'),
                         width: 34,
                         height: 46,
                         scaledWidth: 34,
                         scaledHeight: 46
                     })
      marker.shadow nil
      marker.json({ id: facility.id })
    end

    adopted_practices = helpers.is_user_a_guest? ? Practice.get_facility_adopted_practices(@va_facility.id, nil, nil, true) : Practice.get_facility_adopted_practices(@va_facility.id, nil, nil, false)
    @adopted_pr_count = adopted_practices.size
    @adopted_practices_categories = get_categories_by_practices(adopted_practices, [])
    created_practices = helpers.is_user_a_guest? ? Practice.get_facility_created_practices(@va_facility.id, nil, 'a_to_z', nil, true) : Practice.get_facility_created_practices(@va_facility.id, nil, 'a_to_z', nil, false)
    @created_pr_count = created_practices.size
    @created_practices_categories = get_categories_by_practices(created_practices, [])
  end

  # GET /facilities/:id/created_practices
  def created_practices
    page = 1
    page = params[:page].to_i if params[:page].present?
    sort_option = params[:sort_option] || 'a_to_z'
    search_term = params[:search_term] ? params[:search_term].downcase : nil
    categories = params[:categories] || nil
    created_practices = helpers.is_user_a_guest? ? Practice.get_facility_created_practices(@va_facility.id, search_term, sort_option, categories, true) : Practice.get_facility_created_practices(@va_facility.id, search_term, sort_option, categories, false)

    @pagy_created_practices = pagy_array(
      created_practices,
      items: 3,
      page: page
    )
    @pagy_created_info = @pagy_created_practices[0]
    practices = @pagy_created_practices[1]
    practice_cards_html = ''
    practices.each do |pr|
      pr_html = render_to_string('shared/_practice_card', layout: false, locals: { practice: pr })
      practice_cards_html += pr_html
    end
    respond_to do |format|
      format.html
      format.json { render :json => { practice_cards_html: practice_cards_html, count: created_practices.size, next: @pagy_created_info.next } }
    end
  end

  def update_practices_adopted_at_facility
    selected_cat = params["selected_category"].present? ?  params["selected_category"] : nil
    key_word = params["key_word"].present? ? params["key_word"] : nil
    adoptions_at_facility = helpers.is_user_a_guest? ? Practice.get_facility_adopted_practices(@va_facility.id, key_word, selected_cat, true) : Practice.get_facility_adopted_practices(@va_facility.id, key_word, selected_cat, false)

    adopted_facility_results_html = ''
    adoptions_at_facility.each do |pr|
      pr_html = render_to_string('va_facilities/_adopted_facility_table_row', layout: false, locals: { ad: pr })
      adopted_facility_results_html += pr_html
    end

    respond_to do |format|
      format.html
      format.json { render :json => {adopted_facility_results_html: adopted_facility_results_html, count: adoptions_at_facility.size } }
    end
  end

  private

  def set_va_facility
    @va_facility = VaFacility.select(:id, :common_name, :fy17_parent_station_complexity_level, :mailing_address_city, :station_number, :station_number_suffix_reservation_effective_date, :official_station_name, :street_address, :street_address_city, :street_address_zip_code, :station_phone_number, :street_address_state, :latitude, :longitude, :slug, :rurality).friendly.find(params[:id])
  end
end
