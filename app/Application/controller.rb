require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class ApplicationController < Rho::RhoController
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

  def resultCssClass
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

  def databaseFilePath
    begin
      value = @params['value']
      @result = Rho::Application.databaseFilePath(value)
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :app_databaseFilePath
  end

  def expandDatabaseBlobFilePath
    begin
      value = @params['value']
      @result = Rho::Application.expandDatabaseBlobFilePath(value)
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :app_expandDatabaseBlobFilePath
  end

  def minimize()
    begin
      Rho::Application.minimize()
      be_success
    rescue Exception => e
      puts '======================= exception hadler ======================='
      puts e.message
      be_error
    end
    render :action => :app_expandDatabaseBlobFilePath
  end

  def modelFolderPath
    begin
      value = @params['value']
      @result = Rho::Application.modelFolderPath(value)
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :app_modelFolderPath
  end

  def quit
    begin
      Rho::Application.quit()
      be_success
    rescue Exception => e
      puts '======================= exception hadler ======================='
      puts e.message
      be_error
    end
    render :action => :app_app_quit
  end

  def relativeDatabaseBlobFilePath
    begin
      value = @params['value']
      @result = Rho::Application.relativeDatabaseBlobFilePath(Rho::Application.databaseBlobFolder + '/' + value)
      be_success
    rescue Exception => e
      @result = e.message
      be_error
    end
    render :action => :app_relativeDatabaseBlobFilePath
  end

  def restore
    begin
      Rho::Application.minimize
      sleep(2)
      Rho::Application.restore
      @result = 'The application has been restored successfully'
      be_success
    rescue Exception => e
      puts e.message
      be_error
    end
    render :action => :app_restore
  end

  def applicationNotifyCallback
    value = @params['applicationEvent']
    @result = value.to_s
  end

  def setApplicationNotify
    begin
      Rho::Application.setApplicationNotify(url_for(:action => :applicationNotifyCallback))
      be_success
    rescue Exception => e
      puts e.message
      be_error
    end
    render :action => :app_setApplicationNotify
  end

end


