class ApplicationController < ActionController::Base
  # -- breadcrumbs
  include Wobapphelpers::Breadcrumbs
  before_action :add_breadcrumb_index,
                :if => proc {|c| !c.request.format.js? && 
                                 !devise_controller? &&
                                 c.controller_name != 'login' &&
                                 c.action_name == 'index' }

  before_action :set_paper_trail_whodunnit
  before_action :set_session_mode

  # -- flash responder
  self.responder = Wobapphelpers::Responders
  respond_to :html, :json, :js

  helper_method :add_breadcrumb
  protect_from_forgery prepend: true
  # -- authorization
  load_and_authorize_resource :unless => :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from CanCan::AccessDenied, :with => :access_denied

protected

  def access_denied(exception)
    flash.now[:error] = "Keine Berechtigung für diese Aktion!"
    if Rails.env == 'development'
      Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    end
    respond_to do |format|
      format.js   { render 'errors/access_denied' }
      format.html {
        add_breadcrumb("Fehlerseite", '#')
        render 'errors/show_error', :status => 401
      }
    end
  end

  def record_not_found (exception)
    flash[:error] = exception.message
    respond_to do |format|
      format.js { render 'errors/show_error' }
      format.html do
        if @controller.respond_to? :index
          redirect_to url_for(:action => 'index')
        else
          render 'errors/show_error', :status => :unprocessable_entity
        end
      end
    end
  end

  def set_session_mode
    if ['index', 'show'].include?(action_name)
      session[:mode] = "#{controller_name}##{action_name}"
    end
  end
   
end
