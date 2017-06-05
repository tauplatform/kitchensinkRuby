require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class KeyCaptureController < Rho::RhoController
  include BrowserHelper

  def index
    @title = 'Config'
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

  def capture_key
    render action: :capture_key
  end

  def capture_trigger
    render action: :capture_trigger
  end

  def on_key_captured
    puts "Key Captured: #{@params}"
    begin
      Rho::WebView.executeJavascript("showResult('#{@params.to_s}')")
    rescue Exception => e
      Rho::WebView.executeJavascript("showError('#{e.message}')")
    end
  end

  def do_capture_key
    Rho::KeyCapture.captureKey(false, "ALL", url_for(:action => :on_key_captured));
  end

  def do_stop_capture_key
    Rho::KeyCapture.captureKey(false, "ALL");
  end

  def on_key_triggered
    puts "Key Captured: #{@params}"
    begin
      Rho::WebView.executeJavascript("showResult('#{@params.to_s}')")
    rescue Exception => e
      Rho::WebView.executeJavascript("showError('#{e.message}')")
    end
  end

  def do_capture_trigger
    Rho::KeyCapture.captureTrigger(url_for(:action => :on_key_triggered));
  end

  def do_stop_capture_trigger
    Rho::KeyCapture.captureTrigger();
  end

end


