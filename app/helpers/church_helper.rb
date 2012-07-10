module ChurchHelper
  def church_options_for_select(object)
    church_id = object.group_id || params[:group_id]
    options_for_select([["Parish", "parish"], ["All Saints", "all-saints"], ["St Edmund's", "st-edmunds"], ["St Mary's", "st-marys"], ["St Antony's", "st-antonys"]], church_id)
  end
  
end