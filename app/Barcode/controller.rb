require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class BarcodeController < Rho::RhoController
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

  def enumerate
    begin
      @result = Rho::Barcode.enumerate.collect { |each| each.scannerType }
      @result = 'Barcode scanners have been not found' if @result.empty?
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :barcode_enumerate
  end

  def get_all_properties
    render :action => :barcode_get_all_properties
  end

  def do_get_all_properties
    begin
      @result = Rho::Barcode.getAllProperties
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :barcode_get_all_properties
  end

  def take_picture
    unless @params.empty?
      @result = @params
      be_success
    end
    render :action => :barcode_take
  end

  def do_take
    Rho::Barcode.take({}, url_for(:action => :take_callback))
    redirect :action => :barcode_take
  end

  def take_callback
    @params.delete("rho_callback")
    Rho::WebView.navigate url_for :action => :take_picture, :query => @params
  end

end


