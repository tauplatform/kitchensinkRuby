require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class BatteryController < Rho::RhoController
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

  def be_success
    @resultStatus = 'success';
  end

  def be_error
    @resultStatus = 'error';
  end

  def result_css_class
    temp = @result.nil? ? 'hidden' : ''
    return temp if @result.nil?
    if success?
      temp = temp + ' alert-success'
    end

    if error?
      temp = temp + ' alert-danger'
    end
    return temp
  end

  def image_uri
    if @result.nil? || @result.empty?
      ''
    else
      @result['imageUri']
    end
  end

  def properties
    render :action => :properties
  end

  def battery_status
    render :action => :battery_status
  end

  def on_battery_status_changed
    puts "Battery Event Fired: #{@params}"
    puts "Battery Event (Asynchronous). AC Line Status: #{@params["acLineStatus"]}, Battery Life Percent: #{@params["batteryLifePercent"]}, Backup Battery Life Percent: #{@params["backupBatteryLifePercent"]}, Status: #{@params["batteryStatus"]}, Battery Life Known: #{@params["batteryLifeKnown"]}, Backup Battery Life Known: #{@params["backupBatteryLifeKnown"]}"
    begin
      Rho::WebView.executeJavascript("showResult('#{@params.to_s}')")
    rescue Exception => e
      Rho::WebView.executeJavascript("showError('#{e.message}')")
    end
  end

  def do_update_periodically
    Rho::Battery.batteryStatus({trigger: Rho::Battery::BATTERY_TRIGGER_PERIODIC}, url_for(:action => :on_battery_status_changed))
  end

  def do_on_status_changed
    Rho::Battery.batteryStatus({trigger: Rho::Battery::BATTERY_TRIGGER_SYSTEM}, url_for(:action => :on_battery_status_changed))
  end


  def do_stop_battery_status
    Rho::Battery.stopBatteryStatus()
  end

  def show_hide_icon
    render :action => :battery_icon
  end

  def do_show_icon
    Rho::Battery.showIcon({left: 10, top: 10, layout: Rho::Battery::BATTERY_LAYOUT_UP});
  end

  def do_hide_icon
    Rho::Battery.hideIcon();
  end

end


