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

  def run_application
    render :action => :system_run_application
  end

  def do_run_application_google_store
    app_name = 'market://details?id=com.facebook.katana'
    Rho::System.runApplication(app_name)
  end

  def do_run_application_apple_store
    app_name = 'itms://itunes.apple.com/us/album/bach-brandenburg-concertos-orchestral-suites-violin/id73409969'
    Rho::System.runApplication(app_name)
  end


  def do_run_application_google_maps
    app_name = 'geo:37.422, -122.084'
    Rho::System.runApplication(app_name)
  end

  def do_run_application_apple_maps
    app_name = 'maps://maps.apple.com/?address=1,Infinite+Loop,Cupertino,California'
    Rho::System.runApplication(app_name)
  end

  def do_open_url_tel
    url = 'tel:555-555'
    Rho::System.openUrl(url)
  end

  def do_open_url_sms
    url = 'sms:555-555'
    Rho::System.openUrl(url)
  end

  def do_open_url_google_store
    url = 'market://details?id=com.facebook.katana'
    Rho::System.openUrl(url)
  end

  def do_open_url_apple_store
    url = 'itms://itunes.apple.com/us/album/bach-brandenburg-concertos-orchestral-suites-violin/id73409969'
    Rho::System.openUrl(url)
  end

  def do_open_url_google_maps
    url = 'geo:37.422, -122.084'
    Rho::System.openUrl(url)
  end

  def do_open_url_apple_maps
    app_name = 'maps://maps.apple.com/?address=1,Infinite+Loop,Cupertino,California'
    Rho::System.runApplication(app_name)
  end
end


