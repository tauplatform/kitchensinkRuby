require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class ConfigController < Rho::RhoController
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

  def config_path
    render action: :config_path
  end

  def do_config_path
    begin
      @result = Rho::Config.configPath
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render action: :config_path
  end


  def get_set_property
    render action: :get_set_property
  end


  def do_set_property
    begin
      value = @params['value']
      name =  @params['name']
      Rho::Config.setPropertyString(name, value, false);
      @result = "The value \"#{value}\" is assigned to \"#{name}\""
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render action: :get_set_property
  end

  def do_get_property
    begin
      name =  @params['name']
      if Rho::Config.isPropertyExists(name)
        value = Rho::Config.getPropertyString(name);
        @result = "The value of \"#{name}\" is \"#{value}\" "
      else
        @result = "The setting \"#{name}\" doesn't exist"
      end
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render action: :get_set_property
  end


end


