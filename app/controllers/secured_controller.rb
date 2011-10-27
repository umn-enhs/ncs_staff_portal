class SecuredController < ApplicationController
  protect_from_forgery
  include Aker::Rails::SecuredController 
  
  before_filter :set_current_staff

  def dashboard
    if current_user.permit?(Role::STAFF_SUPERVISOR)
      redirect_to staff_weekly_expenses_path
    else
      redirect_to new_staff_management_task_path(@current_staff.id) 
    end
  end

  def set_current_staff
    @current_staff = Staff.find_by_username(current_user.username)
    unless @current_staff && @current_staff.is_active
      throw :warden
    end
  end
  
  def check_user_access(requested_staff)
    unless requested_staff.id == @current_staff.id or @current_staff.visible_employees.map(&:id).include?(requested_staff.id) 
      throw :warden
    end   
  end
  
  def same_as_current_user(requested_staff)
    requested_staff.id == @current_staff.id ? true : false
  end
end
