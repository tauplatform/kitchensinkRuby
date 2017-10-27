require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class IntentController < Rho::RhoController
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

  def intent_send
    render :action => :intent_send
  end

  def do_open_google_store
    package_name = 'com.facebook.katana'
    data = {
        intentType: Rho::Intent::START_ACTIVITY,
        action: 'ACTION_VIEW',
        uri: "market://details?id=#{package_name}"
    }
    Rho::Intent.send(data);
  end

  def do_open_apple_store
    data = {
        uri: 'itms://itunes.apple.com/us/album/bach-brandenburg-concertos-orchestral-suites-violin/id73409969'
    }
    Rho::Intent.send(data);
  end


  def do_open_google_maps
    data = {
        :intentType => Rho::Intent::START_ACTIVITY,
        action: 'ACTION_VIEW',
        :uri => 'geo:37.422, -122.084'
    }
    Rho::Intent.send data
  end

  def do_open_apple_maps
    data = {
        :uri => 'maps://maps.apple.com/?address=1,Infinite+Loop,Cupertino,California'
    }
    Rho::Intent.send data
  end

end


