class UserDatatable < AjaxDatatablesRails::Base
  
  include AjaxDatatablesRails::Extensions::Kaminari

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['name' ,'email']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['users.name' ,'users.email']
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name,
        record.email,
        record.phoneno,
        record.dob,
        record.created_at
      ]
    end
  end

  def get_raw_records
    # insert query here
    User.all
  end
  
  def sort_column
    columns = %w[name email created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
