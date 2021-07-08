# Team resource helper.
#
module TeamresourcesHelper
  # Get user name from hash key
  #
  # @param [Symbol] key concatinate user id and project id. ex: USER1PROJECT10
  # @return [String] user name.
  def get_user_name(key)
    User.find_by(id: key.to_s.split("USER")[1].split("PROJECT")[0]) || l(:no_assigned)
  end

  # Get project name from hash key
  #
  # @param [Symbol] key concatinate user id and project id. ex: USER1PROJECT10
  # @return [String] project name.
  def link_to_member_project(key)
    project_id = key.to_s.split("USER")[1].split("PROJECT")[1]
    proj = Project.find_by(id: project_id)
    link_to(proj.name, project_path(proj) + "/issues")
  end

  # Label total
  #
  # @param [String] hours of day
  # @return [String] caption of total
  def label_total_time(hours_of_day)
    if hours_of_day.to_s == "1.0"
      l(:label_total_hours)
    else
      l(:label_total_days)
    end
  end

  # put value row user of project
  #
  # @param [String] hours of day
  # @return [String] caption of total
  def value_row(key, range_month, summarize_by_month, hours_of_day)
    ret = tag.td(link_to_member_project(key))
    range_month.each do |year_month|
      ret += tag.td((summarize_by_month[key][year_month].to_f/hours_of_day.to_f).round(1), id: "sumrized_value")
    end
    tag.tr(ret)
  end

  # put total of user row
  #
  # @param [String] hours of day
  # @return [String] caption of total
  def total_row(key, range_month, summarize_user_total_by_month, hours_of_day)
    ret = tag.td(label_total_time(hours_of_day))
    range_month.each do |year_month|
      ret += tag.td((summarize_user_total_by_month[key.to_s.split("PROJECT")[0]][year_month].to_f/hours_of_day.to_f).round(1), id: "total_value")
    end
    tag.tr(ret, id: "total_row")
  end

  # put header row
  #
  # @param [String] hours of day
  # @return [String] caption of total
  def header_row(range_month)
    ret = tag.th(l(:label_project), id: "hdear_project")
    range_month.each do |year_month|
      ret += tag.th(year_month, id: "header_month")
    end
    tag.tr(ret)
  end

  # put user and table
  #
  # @param [String] hours of day
  # @return [String] caption of total
  def user_and_table_start(key)
    ret = tag.h2(get_user_name(key))
    ret += "<table id='sumrized_table' border='1' bordercolor = '#bbb'>".html_safe
  end
end
