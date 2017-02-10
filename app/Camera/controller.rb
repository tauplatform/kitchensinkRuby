require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class CameraController < Rho::RhoController
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

  def choose_picture
    unless @params.empty?
      @result = @params
      be_success
    end
    render :action => :camera_choose_picture
  end

  def do_choose_picture
    Rho::Camera.choosePicture({}, url_for(:action => :choose_picture_callback))
    redirect :action => :choose_picture
  end

  def choose_picture_callback
    @params.delete("rho_callback")
    Rho::WebView.navigate url_for :action => :choose_picture, :query => @params
  end

  def enumerate
    begin
      @result = Rho::Camera.enumerate
      @result = 'Cameras have been not found' if @result.empty?
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :camera_enumerate
  end

  def get_all_properties
    render :action => :camera_get_all_properties
  end

  def do_get_all_properties
    begin
      @result = Rho::Camera.getAllProperties
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :camera_get_all_properties
  end

  def show_hide_preview
    render :action => :camera_show_hide_preview
  end

  def take_picture
    unless @params.empty?
      @result = @params
      be_success
    end
    render :action => :camera_take_picture
  end

  def do_take_picture
    Rho::Camera.takePicture({}, url_for(:action => :take_picture_callback))
    redirect :action => :take_picture
  end

  def take_picture_callback
    @params.delete("rho_callback")
    Rho::WebView.navigate url_for :action => :take_picture, :query => @params
  end

end


