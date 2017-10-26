require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class SystemController < Rho::RhoController
  include BrowserHelper

  def index
    render
  end

  def success?
    return @resultStatus == 'success'
  end

  def error?
    return @resultStatus == 'error'
  end

  def be_success(aString)
    @result = aString
    @resultStatus = 'success'
  end

  def be_error(aString)
    @result = aString
    @resultStatus = 'error'
  end

  def result_css_class
    if @result.nil?
      return 'hidden'
    end
    if success?
      return 'alert-success'
    end
    if error?
      return 'alert-danger'
    end
  end

  def open_url
    render :action => :system_open_url
  end

  def do_open_url
    begin
      value = @params['value']
      be_success(Rho::System.openUrl(value))
    rescue Exception => e
      be_error(e.message)
    end
    render :action => :system_open_url
  end

end


